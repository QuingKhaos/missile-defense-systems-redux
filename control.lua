--- @class (partial) MissileDefenseSystemsRedux.Storage
--- @field mds_ballistic_turrets table<uint64, LuaEntity>
--- @field mds_ballistic_artillery_volleys table<uint64, {entity: LuaEntity, flare: LuaEntity, position: MapPosition, started: MapTick, manual: boolean?}>
--- @field mds_ballistic_artillery_reloading table<uint64, {entity: LuaEntity, reload_until: MapTick}>
--- @field mds_ballistic_blocked table<uint64, boolean>
--- @field mds_ballistic_burst_counts table<uint64, uint>
storage = storage --[[@as MissileDefenseSystemsRedux.Storage]] or {}

local turret_name = "ballistic-missile-defense-system"
local flare_name = "mds-ballistic-flare"

local barrage_size = 10
local reload_ticks = 5 * 60

local max_range = settings.startup["mds-ballistic-max-range"].value
local min_range = settings.startup["mds-ballistic-minimum-range"].value

local function init_artillery_storage()
  storage.mds_ballistic_turrets = storage.mds_ballistic_turrets or {}
  storage.mds_ballistic_artillery_volleys = storage.mds_ballistic_artillery_volleys or {}
  storage.mds_ballistic_artillery_reloading = storage.mds_ballistic_artillery_reloading or {}
  storage.mds_ballistic_blocked = storage.mds_ballistic_blocked or {}
  storage.mds_ballistic_burst_counts = storage.mds_ballistic_burst_counts or {}
end

--- @param turret LuaEntity
local function register_ballistic_turret(turret)
  if turret and turret.valid and turret.name == turret_name then
    init_artillery_storage()
    storage.mds_ballistic_turrets[turret.unit_number] = turret
  end
end

local function rescan_ballistic_turrets()
  init_artillery_storage()
  storage.mds_ballistic_turrets = {}
  for _, surface in pairs(game.surfaces) do
    for _, turret in pairs(surface.find_entities_filtered{name = turret_name}) do
      register_ballistic_turret(turret)
    end
  end
end

local function ballistic_shot_fired_handler(args)
  local entity = args.source_entity
  if not (entity and entity.valid) then return end

  init_artillery_storage()
  local uid = entity.unit_number
  local count = (storage.mds_ballistic_burst_counts[uid] or 0) + 1
  storage.mds_ballistic_burst_counts[uid] = count

  if count >= barrage_size then
    storage.mds_ballistic_burst_counts[uid] = nil
      local volleys = storage.mds_ballistic_artillery_volleys
      local volley = volleys and volleys[uid]
      if volley then
        if volley.flare and volley.flare.valid then volley.flare.destroy() end
        volleys[uid] = nil
      end

    entity.active = false
    storage.mds_ballistic_artillery_reloading[uid] = {
      entity = entity,
      reload_until = game.tick + reload_ticks,
    }
  end
end

local function distance_between(a, b)
  local dx = a.x - b.x
  local dy = a.y - b.y
  return math.sqrt(dx * dx + dy * dy)
end

local function effective_max_range(turret)
  local multiplier = 1
  pcall(function() multiplier = 1 + (turret.force.artillery_range_modifier or 0) end)
  return max_range * multiplier
end

local function can_engage(turret, pos)
  local distance = distance_between(turret.position, pos)
  if distance < min_range then return false, "too-close" end
  if distance > effective_max_range(turret) then return false, "too-far" end
  return true
end

local function is_auto_on(turret)
  local ok, valid = pcall(function() return turret.artillery_auto_targeting end)
  if not ok then return true end
  return valid and true or false
end

local function mds_artillery_try_open_volley(turret, tick)
    if not (turret and turret.valid) then return end
    init_artillery_storage()

    local uid = turret.unit_number
    if storage.mds_ballistic_artillery_volleys[uid] then return end
    if not is_auto_on(turret) then return end

    local has_ammo = true
    pcall(function() has_ammo = turret.has_items_inside() end)
    if not has_ammo then return end

    local candidates = turret.surface.find_entities_filtered{
      position = turret.position,
      radius = effective_max_range(turret),
      force = "enemy",
      type = {"unit-spawner", "turret"},
    }

    local best, best_distance = nil, nil
    for _, candidate in pairs(candidates) do
      if candidate.valid and can_engage(turret, candidate.position) then
        local distance = distance_between(turret.position, candidate.position)
        if best_distance == nil or distance < best_distance then best, best_distance = candidate, distance end
      end
    end

    if not best then return end

    local flare = turret.surface.create_entity{
      name = flare_name,
      position = best.position,
      force = turret.force,
      movement = {0, 0},
      height = 0,
      vertical_speed = 0,
      frame_speed = 0,
    }

    if flare then
      storage.mds_ballistic_artillery_volleys[uid] = {
        entity = turret,
        flare = flare,
        position = best.position,
        started = tick or game.tick,
      }
    end
  end

script.on_nth_tick(30, function(event)
  local reloading = storage.mds_ballistic_artillery_reloading
  if not reloading then return end

  for uid, data in pairs(reloading) do
    if not (data.entity and data.entity.valid) then
      reloading[uid] = nil
    elseif event.tick >= data.reload_until then
      mds_artillery_try_open_volley(data.entity, event.tick)
      data.entity.active = true
      reloading[uid] = nil
    end
  end
end)

local built_filter = {{ filter = "name", name = turret_name }}
local function on_built(event)
  register_ballistic_turret(event.entity)
  mds_artillery_try_open_volley(event.entity)
end

script.on_event(defines.events.on_built_entity, on_built, built_filter)
script.on_event(defines.events.on_robot_built_entity, on_built, built_filter)
script.on_event(defines.events.script_raised_built, on_built, built_filter)
script.on_event(defines.events.script_raised_revive, on_built, built_filter)

local function collect_flares()
  init_artillery_storage()
  local tracked = {}
  for _, volley in pairs(storage.mds_ballistic_artillery_volleys) do
    if volley.flare and volley.flare.valid then table.insert(tracked, volley.flare) end
  end

  local function is_tracked(flare)
    for _, t in pairs(tracked) do
      if t == flare then return true end
    end
    return false
  end

  local all, discovered = {}, {}
  for _, t in pairs(tracked) do table.insert(all, t) end

  for _, surface in pairs(game.surfaces) do
    for _, flare in pairs(surface.find_entities_filtered{ name = flare_name }) do
      if not is_tracked(flare) then
        table.insert(discovered, flare)
        table.insert(all, flare)
      end
    end
  end

  return all, discovered
end

script.on_nth_tick(20, function(event)
  init_artillery_storage()
  local turrets = storage.mds_ballistic_turrets
  local volleys = storage.mds_ballistic_artillery_volleys
  local reloading = storage.mds_ballistic_artillery_reloading
  local blocked = storage.mds_ballistic_blocked
  local sps = settings.startup["mds-ballistic-shots-per-second"].value --[[@as integer]]
  local volley_timeout = math.ceil(barrage_size / math.max(sps, 0.1)) * 60 + 20 * 60

  for uid, volley in pairs(volleys) do
    local turret_ok = volley.entity and volley.entity.valid
    local flare_ok = volley.flare and volley.flare.valid

    if not turret_ok then
      if flare_ok then volley.flare.destroy() end
      volleys[uid] = nil
      storage.mds_ballistic_burst_counts[uid] = nil
    elseif not flare_ok then
      volleys[uid] = nil
      storage.mds_ballistic_burst_counts[uid] = nil
    elseif event.tick - volley.started > volley_timeout then
      volley.flare.destroy()
      volleys[uid] = nil
      storage.mds_ballistic_burst_counts[uid] = nil
    end
  end

  local flares, discovered = collect_flares()
  for _, flare in pairs(discovered) do
    local flare_position = flare.position
    local flare_surface = flare.surface
    local best_reason = nil
    local responding = 0

    for uid, turret in pairs(turrets) do
      if turret.valid and turret.surface == flare_surface then
        local ok, reason = can_engage(turret, flare_position)
        if ok then
          local old = volleys[uid]
          if old and old.flare and old.flare.valid then old.flare.destroy() end

          local new_flare = turret.surface.create_entity{
            name = flare_name,
            position = flare_position,
            force = turret.force,
            movement = { 0, 0 },
            height = 0,
            vertical_speed = 0,
            frame_speed = 0,
          }

          if new_flare then
            volleys[uid] = {entity = turret, flare = new_flare, position = flare_position, started = event.tick, manual = true}
            responding = responding + 1
          end
        else
          best_reason = best_reason or reason
        end
      end
    end

    if flare.valid then flare.destroy() end

    if responding > 0 then
      game.print("[Missile Defense Systems] Ballistic strike ordered - " .. responding .. " launcher(s) responding.")
    else
      local why = "no Ballistic launcher in range"
      if best_reason == "too-close" then why = "target is inside the Ballistic launchers' minimum range"
      elseif best_reason == "too-far" then why = "target is beyond every Ballistic launcher's range" end
      game.print("[Missile Defense Systems] Ballistic strike REFUSED - " .. why .. ".")
    end
  end

  if #discovered > 0 then flares = collect_flares() end

  local flares_exist = #flares > 0
  for uid, turret in pairs(turrets) do
    if not turret.valid then
      turrets[uid] = nil
      blocked[uid] = nil
    else
      local is_reloading = reloading[uid] ~= nil
      local has_volley = volleys[uid] ~= nil
      local auto_on = is_auto_on(turret)

      if not is_reloading then
        if has_volley then
          if blocked[uid] then
            blocked[uid] = nil
            turret.active = true
          end
        elseif auto_on then
          if blocked[uid] then
            blocked[uid] = nil
            turret.active = true
          end

          if turret.active then
            mds_artillery_try_open_volley(turret, event.tick)
          end
        else
          if flares_exist then
            if not blocked[uid] then
              blocked[uid] = true
              turret.active = false
            end
          elseif blocked[uid] then
            blocked[uid] = nil
            turret.active = true
          end
        end
      end
    end
  end
end)

--- @param event EventData.on_script_trigger_effect
local function map_reveal_handler(event, offset)
  local pos = event.target_position

  if pos == nil or pos == {} then
    if event.target_entity ~= nil and event.target_entity.valid then
      pos = event.target_entity.position
    else
      return
    end
  end

  local chunk_size = 32
  local chunk_pos = {
    x = math.floor((pos.x or 0) / chunk_size),
    y = math.floor((pos.y or 0) / chunk_size),
  }

  local area = {
    left_top = {
      x = (chunk_pos.x - offset) * chunk_size,
      y = (chunk_pos.y - offset) * chunk_size,
    },
    right_bottom = {
      x = (chunk_pos.x + offset) * chunk_size,
      y = (chunk_pos.y + offset) * chunk_size,
    },
  }

  local surface = game.get_surface(event.surface_index)
  if surface then
    game.forces.player.chart(surface, area)
  end
end

--- @param event EventData.on_script_trigger_effect
local function script_trigger_effect_handler(event)
  if event.effect_id == "mds-map-reveal-large" then
    map_reveal_handler(event, 1)
  elseif event.effect_id == "mds-map-reveal-small" then
    map_reveal_handler(event, 0)
  elseif event.effect_id == "mds-ballistic-shot-fired" then
    ballistic_shot_fired_handler(event)
  end
end

script.on_event(defines.events.on_script_trigger_effect, script_trigger_effect_handler)

script.on_init(function()
  rescan_ballistic_turrets()
end)

script.on_configuration_changed(function()
  rescan_ballistic_turrets()
end)
