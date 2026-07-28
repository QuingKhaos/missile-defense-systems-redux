local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")

local recipe = khaoslib_recipe:load {
  type = "recipe",
  name = "ballistic-missile-defense-system",
  subgroup = "turret",
  order = "b[turret]-c[mds]-c[ballistic]",
  enabled = false,
  energy_required = 10,
} :set_ingredients {
  {type = "item", name = "advanced-missile-defense-system", amount = 1},
  {type = "item", name = "steel-plate", amount = 50},
  {type = "item", name = "processing-unit", amount = 10},
} :set_results {
  {type = "item", name = "ballistic-missile-defense-system", amount = 1},
} :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/ballistic-missile-defense-system.png", icon_size = 64}}

if mods["space-age"] then
  recipe:add_ingredient({type = "item", name = "carbon-fiber", amount = 50})
    :add_ingredient({type = "item", name = "tungsten-plate", amount = 100})
end

recipe:commit()
