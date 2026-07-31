local ballistic_constants = require("prototypes.ballistic-constants")
local khaoslib_artillery_projectile = require("__khaoslib__.prototypes.artillery-projectile")
local khaoslib_projectile = require("__khaoslib__.prototypes.projectile")
local khaoslib_trigger_item = require("__khaoslib__.prototypes.trigger-item")
local khaoslib_trigger_delivery_item = require("__khaoslib__.prototypes.trigger-delivery-item")

khaoslib_artillery_projectile.copy("artillery-projectile", "mds-ballistic-artillery-projectile-atomic-bomb")
  :set {
    reveal_map = false,
    rotatable = true,
    height_from_ground = ballistic_constants.height,
  }
  :unset("picture")
  :unset("shadow")
  :set {
    picture = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.2, 0.2}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
  }
  :unset("action")
  :set {
    action = khaoslib_projectile.get("atomic-rocket").action,
  }
  :replace_action(function(action)
    --- @cast action data.DirectTriggerItem
    return action.type == "direct" and action.action_delivery ~= nil
  end, function(action)
    return khaoslib_trigger_item:load(action)
      :replace_action_delivery(function(delivery)
        --- @cast delivery data.ProjectileTriggerDelivery
        return delivery.type == "instant" and delivery.target_effects ~= nil
      end, function(delivery)
        return khaoslib_trigger_delivery_item:load(delivery)
          :replace_target_effect(function(target_effect)
            --- @cast target_effect data.DamageEntityTriggerEffectItem
            return target_effect.type == "damage" and target_effect.damage ~= nil
          end, function(target_effect)
            return {
              type = "nested-result",
              action = {
                type = "area",
                radius = ballistic_constants.core_radius,
                force = "enemy",
                action_delivery = {
                  type = "instant",
                  target_effects = {target_effect},
                },
              },
            }
          end):get()
      end):get()
  end)
  :commit()
