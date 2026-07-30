local khaosbash = require("__khaosbash__.prototypes.lib")
local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

if mods["chemical-rocket"] then
  khaoslib_recipe:load {
    type = "recipe",
    name = "mds-ballistic-chemical-missile",
    energy_required = 10,
    enabled = false,
  } :set_ingredients {
    {type = "item", name = "chemical-rocket", amount = 10},
    {type = "item", name = "steel-plate", amount = 2},
  } :set_results {
    {type = "item", name = "mds-ballistic-chemical-missile", amount = 1},
  } :set_icons(khaosbash.load_icons("__missile-defense-systems-redux__/graphics/icons/mds-ballistic-missile", util.color("1ae5fc")))
    :set_categories {"crafting"}
    :commit()
end
