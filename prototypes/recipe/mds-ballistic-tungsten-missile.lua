local khaosbash = require("__khaosbash__.prototypes.lib")
local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

if mods["space-age"] then
  khaoslib_recipe:load {
    type = "recipe",
    name = "mds-ballistic-tungsten-missile",
    energy_required = 10,
    enabled = false,
  } :set_ingredients {
    {type = "item", name = "iron-plate", amount = 20},
    {type = "item", name = "steel-plate", amount = 12},
    {type = "item", name = "explosives", amount = 20},
    {type = "item", name = "tungsten-carbide", amount = 20},
  } :set_results {
    {type = "item", name = "mds-ballistic-tungsten-missile", amount = 1},
  } :set_icons(khaosbash.load_icons("__missile-defense-systems-redux__/graphics/icons/mds-ballistic-missile", util.color("a365b6")))
    :set_categories {"crafting"}
    :commit()
end
