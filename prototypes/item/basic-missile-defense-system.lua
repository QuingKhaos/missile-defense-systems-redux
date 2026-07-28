local khaoslib_item = require("__khaoslib__.prototypes.item")

khaoslib_item:load {
  type = "item",
  name = "basic-missile-defense-system",
  subgroup = "turret",
  order = "b[turret]-c[mds]-a[basic]",
  place_result = "basic-missile-defense-system",
  stack_size = 50,
} :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/basic-missile-defense-system.png", icon_size = 64}}
  :commit()
