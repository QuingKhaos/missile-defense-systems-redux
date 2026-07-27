local khaoslib_item = require("__khaoslib__.prototypes.item")

khaoslib_item:load {
  type = "item",
  name = "advanced-missile-defense-system",
  subgroup = "turret",
  order = "b[turret]-c[mds]-b[advanced]",
  place_result = "advanced-missile-defense-system",
  stack_size = 50,
} :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/advanced-missile-defense-system.png", icon_size = 64}}
  :commit()
