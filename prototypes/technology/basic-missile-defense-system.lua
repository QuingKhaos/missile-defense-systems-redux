local khaoslib_technology = require("__khaoslib__.prototypes.technology")

khaoslib_technology:load {
	type = "technology",
	name = "basic-missile-defense-system",
	order = "c-a",
  localised_name = {"item-name.basic-missile-defense-system"},
} :set_prerequisites {
  "rocketry",
  "gun-turret",
  "steel-processing",
  "advanced-circuit"
} :set_unit {
  time = 20,
  count = 75,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"military-science-pack", 1},
  },
} :add_unlock_recipe("basic-missile-defense-system")
  :set_icons {{icon = "__missile-defense-systems-redux__/graphics/technology/basic-missile-defense-system.png", icon_size = 128}}
  :commit()
