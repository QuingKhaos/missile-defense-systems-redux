local khaoslib_technology = require("__khaoslib__.prototypes.technology")

khaoslib_technology:load {
	type = "technology",
	name = "ballistic-missile-defense-system",
	order = "c-a",
  localised_name = {"item-name.ballistic-missile-defense-system"},
} :set_prerequisites {
  "artillery",
  "production-science-pack",
  "utility-science-pack",
  "advanced-missile-defense-system",
} :set_unit {
  time = 60,
  count = 5000,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"military-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
  },
} :add_unlock_recipe("ballistic-missile-defense-system")
  :add_unlock_recipe("mds-ballistic-missile")
  :add_unlock_recipe("mds-ballistic-explosive-missile")
  :set_icons {{icon = "__missile-defense-systems-redux__/graphics/technology/ballistic-missile-defense-system.png", icon_size = 256}}
  :commit()
