local ballistic_constants = require("prototypes.ballistic-constants")
local khaoslib_artillery_projectile = require("__khaoslib__.prototypes.artillery-projectile")

if mods["space-age"] then
  khaoslib_artillery_projectile.copy("artillery-projectile", "mds-ballistic-artillery-projectile-tungsten")
    :set {
      reveal_map = false,
      rotatable = true,
      height_from_ground = ballistic_constants.height,
    }
    :unset("picture")
    :unset("shadow")
    :set {
      picture = require("__base__.prototypes.entity.rocket-projectile-pictures").animation(util.color("a365b6")),
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
              entity_name = "big-explosion",
            },
            {
              type = "destroy-cliffs",
              radius = 4,
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
                    {type = "damage", damage = {amount = 200, type = "physical"}},
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
                    {type = "damage", damage = {amount = 500, type = "physical"}},
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
end
