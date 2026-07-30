local ballistic_constants = require("prototypes.ballistic-constants")
local khaoslib_artillery_projectile = require("__khaoslib__.prototypes.artillery-projectile")
local khaoslib_projectile = require("__khaoslib__.prototypes.projectile")

if mods["chemical-rocket"] then
  khaoslib_artillery_projectile.copy("artillery-projectile", "mds-ballistic-artillery-projectile-chemical")
    :set {
      reveal_map = false,
      rotatable = true,
      height_from_ground = ballistic_constants.height,
    }
    :unset("picture")
    :unset("shadow")
    :set {
      picture = require("__base__.prototypes.entity.rocket-projectile-pictures").animation(util.color("1ae5fc")),
      shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    }
    :unset("action")
    :set {action = khaoslib_projectile.get("chemical-rocket").action}
    :commit()
end
