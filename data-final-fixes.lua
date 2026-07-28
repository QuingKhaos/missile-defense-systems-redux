local khaoslib_ammo = require("__khaoslib__.prototypes.ammo")

khaoslib_ammo:load("mds-ballistic-missile"):set {subgroup = "ammo-rocket"} :commit()
khaoslib_ammo:load("mds-ballistic-explosive-missile"):set {subgroup = "ammo-rocket"} :commit()
