local khaoslib_technology = require("__khaoslib__.prototypes.technology")

khaoslib_technology:load {
	type = "technology",
	name = "advanced-missile-defense-system",
	order = "c-a",
  localised_name = {"item-name.advanced-missile-defense-system"},
} :set_prerequisites {
  "basic-missile-defense-system",
  "processing-unit",
  "explosive-rocketry",
  "electric-engine",
} :set_unit {
  time = 30,
  count = 150,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"military-science-pack", 1},
    {"chemical-science-pack", 1},
  },
} :add_unlock_recipe("advanced-missile-defense-system")
  :set_icons {{icon = "__missile-defense-systems-redux__/graphics/technology/advanced-missile-defense-system.png", icon_size = 128}}
  :commit()
