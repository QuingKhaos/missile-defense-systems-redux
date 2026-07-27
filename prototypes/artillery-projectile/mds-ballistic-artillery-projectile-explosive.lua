local ballistic_constants = require("prototypes.ballistic-constants")
local khaoslib_artillery_projectile = require("__khaoslib__.prototypes.artillery-projectile")

khaoslib_artillery_projectile.copy("artillery-projectile", "mds-ballistic-artillery-projectile-explosive")
  :set {
    reveal_map = false,
    rotatable = true,
    height_from_ground = ballistic_constants.height,
  }
  :unset("picture")
  :unset("shadow")
  :set {
    picture = {
      filename = "__missile-defense-systems-redux__/graphics/entity/mds-rocket-projectile.png",
      priority = "high",
      width = 64,
      height = 64,
      scale = 0.45,
    },
    shadow = {
      filename = "__missile-defense-systems-redux__/graphics/entity/mds-rocket-projectile.png",
      priority = "high",
      width = 64,
      height = 64,
      scale = 0.45,
      draw_as_shadow = true,
    },
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
            entity_name = "big-explosion",
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
                  {type = "damage", damage = {amount = 50, type = "explosion"}},
                },
              },
            },
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 6.5,
              force = "enemy",
              action_delivery = {
                type = "instant",
                target_effects =
                {
                  {type = "damage", damage = { amount = 100, type = "explosion" }},
                  {type = "create-entity", entity_name = "explosion", only_when_visible = true},
                },
              },
            },
          },
        },
      },
    },
  }
  :commit()
