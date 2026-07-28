local khaoslib_capsule = require("__khaoslib__.prototypes.capsule")
local khaoslib_sprites = require("__khaoslib__.prototypes.sprites")

local remote = khaoslib_capsule.copy("artillery-targeting-remote", "mds-ballistic-targeting-remote")
  :set {
    capsule_action = {
      type = "artillery-remote",
      flare = "mds-ballistic-flare",
    },
  }

remote:set {order = (remote:get().order or "zz") .. "-mds-b"}
  :set_icons(khaoslib_sprites.tint(remote:get_icons(), {r = 1.0, g = 0.55, b = 0.25}))
  :commit()
