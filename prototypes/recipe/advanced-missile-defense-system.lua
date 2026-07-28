local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

khaoslib_recipe:load {
  type = "recipe",
  name = "advanced-missile-defense-system",
  subgroup = "turret",
  order = "b[turret]-c[mds]-b[advanced]",
  enabled = false,
  energy_required = 10,
} :set_ingredients {
  {type = "item", name = "basic-missile-defense-system", amount = 2},
  {type = "item", name = "steel-plate", amount = 30},
  {type = "item", name = "processing-unit", amount = 3},
  {type = "item", name = "electric-engine-unit", amount = 5},
} :set_results {
  {type = "item", name = "advanced-missile-defense-system", amount = 1},
} :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/advanced-missile-defense-system.png", icon_size = 64}}
  :commit()
