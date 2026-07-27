local khaoslib_entity = require("__khaoslib__.prototypes.entity")

--- @return data.RotatedAnimation8Way
local function mds_animation(inputs)
  return {
    filename = "__missile-defense-systems-redux__/graphics/entity/advanced-missile-defense-system.png",
    priority = "medium",
    scale = 1,
    width = 88,
    height = 80,
    direction_count = inputs.direction_count and inputs.direction_count or 64,
    frame_count = 1,
    line_length = inputs.line_length and inputs.line_length or 16,
    axially_symmetrical = false,
    run_mode = inputs.run_mode and inputs.run_mode or "forward",
    shift = {0.15, -0.5},
  }
end

khaoslib_entity:load {
  type = "ammo-turret",
  name = "advanced-missile-defense-system",
  flags = {"placeable-player", "player-creation"},
  localised_name = {"item-name.advanced-missile-defense-system"},

  corpse = "medium-remnants",
  max_health = 1200,

  collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
  selection_box = {{-1, -1}, {1, 1}},
  rotation_speed = 0.012,
  preparing_speed = 0.05,
  folding_speed = 0.05,
  dying_explosion = "medium-explosion",
  inventory_size = 2,
  automated_ammo_count = 10,
  attacking_speed = 0.08,

  folded_animation = mds_animation {direction_count = 4, line_length = 1},
  preparing_animation = mds_animation {direction_count = 4, line_length = 1},
  prepared_animation = mds_animation {},
  attacking_animation = mds_animation {},
  folding_animation = mds_animation {direction_count = 4, line_length = 1, run_mode = "backward"},

  vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},

  alert_when_attacking = true,
  open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
  close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
  turret_base_has_direction = true,

  attack_parameters = {
    type = "projectile",
    ammo_category = "rocket",
    cooldown = 60 / settings.startup["mds-advanced-fire-rate"].value,
    projectile_creation_distance = 1.2,
    projectile_center = {-0.15625, -0.07812},
    damage_modifier = 1,
    shell_particle = {
      name = "shell-particle",
      direction_deviation = 0.1,
      speed = 0.1,
      speed_deviation = 0.03,
      center = {0, 0},
      creation_distance = -1.925,
      starting_frame_speed = 0.2,
      starting_frame_speed_deviation = 0.1
    },

    range = settings.startup["mds-advanced-max-range"].value,
    min_range = settings.startup["mds-advanced-min-range"].value,
    prepare_range = settings.startup["mds-advanced-max-range"].value + 5,
    shoot_in_prepare_state = false,
    turn_range = settings.startup["mds-advanced-fire-pattern"].value == "arc" and settings.startup["mds-advanced-fire-arc-degree"].value / 360.0 or 1,

    sound = {
      {
        filename = "__base__/sound/fight/rocket-launcher.ogg",
        volume = 0.8
      }
    },
  },

  graphics_set = {},

  call_for_help_radius = 40,
} :set_minable {mining_time = 1.0, result = "advanced-missile-defense-system"}
  :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/advanced-missile-defense-system.png", icon_size = 64}}
  :commit()
