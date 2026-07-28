local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

khaoslib_recipe:load {
  type = "recipe",
  name = "mds-ballistic-missile",
  category = "crafting",
  energy_required = 10,
  enabled = false,
} :set_ingredients {
  {type = "item", name = "rocket", amount = 10},
  {type = "item", name = "steel-plate", amount = 2},
} :set_results {
  {type = "item", name = "mds-ballistic-missile", amount = 1},
} :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/mds-ballistic-missile.png", icon_size = 64}}
  :commit()
