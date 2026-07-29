local khaosbash = require("__khaosbash__.prototypes.lib")
local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

khaoslib_recipe:load {
  type = "recipe",
  name = "mds-ballistic-explosive-missile",
  energy_required = 10,
  enabled = false,
} :set_ingredients {
  {type = "item", name = "explosive-rocket", amount = 10},
  {type = "item", name = "steel-plate", amount = 2},
} :set_results {
  {type = "item", name = "mds-ballistic-explosive-missile", amount = 1},
} :set_icons(khaosbash.load_icons("__missile-defense-systems-redux__/graphics/icons/mds-ballistic-missile", {1, 0.2, 0.2}))
  :set_categories {"crafting"}
  :commit()
