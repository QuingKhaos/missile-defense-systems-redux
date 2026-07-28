local khaoslib_ammo = require("__khaoslib__.prototypes.ammo")
local khaoslib_ammo_type = require("__khaoslib__.prototypes.ammo-type")
local khaoslib_projectile = require("__khaoslib__.prototypes.projectile")
local khaoslib_trigger_item = require("__khaoslib__.prototypes.trigger-item")
local khaoslib_trigger_delivery = require("__khaoslib__.prototypes.trigger-delivery-item")

local small_map_reveal_effect = {
  type = "script",
  effect_id = "mds-map-reveal-small"
}

local large_map_reveal_effect = {
  type = "script",
  effect_id = "mds-map-reveal-large"
}

local effect_map = {
  {ammo = "rocket", projectile = "rocket", effect = small_map_reveal_effect},
  {ammo = "explosive-rocket", projectile = "explosive-rocket", effect = small_map_reveal_effect},
  {ammo = "atomic-bomb", projectile = "atomic-rocket", effect = large_map_reveal_effect},
}

for _, thing in pairs(effect_map) do
  khaoslib_ammo:load(thing.ammo)
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
              return delivery.type == "projectile" and delivery.projectile ~= nil
            end, function(delivery)
              return khaoslib_trigger_delivery:load(delivery)
                :add_target_effect(thing.effect)
                :get()
            end):get()
        end):get()
    end)
    :commit()

  khaoslib_projectile:load(thing.projectile)
    :replace_action(function(action)
      --- @cast action data.DirectTriggerItem
      return action.type == "direct" and action.action_delivery ~= nil
    end, function(action)
      return khaoslib_trigger_item:load(action)
        :replace_action_delivery(function(delivery)
          --- @cast delivery data.ProjectileTriggerDelivery
          return delivery.type == "projectile" and delivery.projectile ~= nil
        end, function(delivery)
          return khaoslib_trigger_delivery:load(delivery)
            :add_target_effect(thing.effect)
            :get()
        end):get()
    end)
    :commit()
end
