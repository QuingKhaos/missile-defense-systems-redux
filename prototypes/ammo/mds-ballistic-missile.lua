local ballistic_constants = require("__missile-defense-systems-redux__.prototypes.ballistic-constants")
local khaoslib_ammo = require("__khaoslib__.prototypes.ammo")
local khaoslib_ammo_type = require("__khaoslib__.prototypes.ammo-type")
local khaoslib_trigger_item = require("__khaoslib__.prototypes.trigger-item")

khaoslib_ammo.copy("rocket", "mds-ballistic-missile")
  :set {
    order = "d[rocket-launcher]-c[mds]-a[basic]",
    ammo_category = "mds-ballistic-missile",
    magazine_size = 10,
  }
  :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/mds-ballistic-missile.png", icon_size = 64}}
  :replace_ammo_type(function(ammo_type)
    return ammo_type.action ~= nil
  end, function(ammo_type)
    return khaoslib_ammo_type:load(ammo_type)
      :replace_action(function(action)
        --- @cast action data.DirectTriggerItem
        return action.type == "direct" and action.action_delivery ~= nil
      end, function(action)
        return khaoslib_trigger_item:load(action)
          :replace_action_delivery(function(delivery)
            --- @cast delivery data.ProjectileTriggerDelivery
            return delivery.type == "projectile" and delivery.projectile == "rocket"
          end, {
            type = "artillery",
            projectile = "mds-ballistic-artillery-projectile",
            starting_speed = ballistic_constants.speed,
            direction_deviation = ballistic_constants.direction_deviation,
            range_deviation = ballistic_constants.range_deviation,
            source_effects = {
              {
                type = "script",
                effect_id = "mds-ballistic-shot-fired",
              },
              {
                type = "create-trivial-smoke",
                smoke_name = "smoke-fast",
                initial_height = 0,
                offset_deviation = {{-0.3, -0.3}, {0.3, 0.3}},
                repeat_count = 3,
              },
            },
          }):get()
      end):get()
  end)
  :commit()
