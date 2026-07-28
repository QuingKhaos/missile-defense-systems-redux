local ballistic_constants = require("prototypes.ballistic-constants")
local khaoslib_artillery_projectile = require("__khaoslib__.prototypes.artillery-projectile")

khaoslib_artillery_projectile.copy("artillery-projectile", "mds-ballistic-artillery-projectile")
  :set {
    reveal_map = false,
    rotatable = true,
    height_from_ground = ballistic_constants.height,
  }
  :unset("picture")
  :unset("shadow")
  :set {
    picture = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.8, 0.3}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
  }
  :unset("action")
  :set {
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "create-entity",
            entity_name = "explosion",
          },
          {
            type = "nested-result",
            action = {
              type = "area",
              radius = ballistic_constants.core_radius,
              force = "enemy",
              action_delivery = {
                type = "instant",
                target_effects = {
                  {type = "damage", damage = {amount = 200, type = "explosion"}},
                },
              },
            },
          },
        },
      },
    },
  }
  :commit()
