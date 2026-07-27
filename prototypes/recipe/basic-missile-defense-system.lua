local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

khaoslib_recipe:load {
  type = "recipe",
  name = "basic-missile-defense-system",
  subgroup = "turret",
  order = "b[turret]-c[mds]-a[basic]",
  enabled = false,
  energy_required = 10,
} :set_ingredients {
  {type = "item", name = "rocket-launcher", amount = 8},
  {type = "item", name = "iron-gear-wheel", amount = 15},
  {type = "item", name = "steel-plate", amount = 15} ,
  {type = "item", name = "advanced-circuit", amount = 1}
} :set_results {
  {type = "item", name = "basic-missile-defense-system", amount = 1}
} :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/basic-missile-defense-system.png", icon_size = 64}}
  :commit()
