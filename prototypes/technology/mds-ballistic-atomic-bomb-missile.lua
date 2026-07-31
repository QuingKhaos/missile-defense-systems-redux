local khaosbash = require("__khaosbash__.prototypes.lib")
local khaoslib_technology = require("__khaoslib__.prototypes.technology")

local tech = khaoslib_technology:load {
	type = "technology",
	name = "mds-ballistic-atomic-bomb-missile",
  localised_name = {"item-name.mds-ballistic-atomic-bomb-missile"},
} :set_prerequisites {
  "ballistic-missile-defense-system",
  "atomic-bomb",
} :set_unit {
  time = 60,
  count = 10000,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"military-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
  },
} :add_unlock_recipe("mds-ballistic-atomic-bomb-missile")
  :set_icons(khaosbash.load_icons("__missile-defense-systems-redux__/graphics/icons/mds-ballistic-missile", {0.3, 1, 0.3}))

if mods["space-age"] then
  tech:add_science_pack({"metallurgic-science-pack", 1})
    :add_science_pack({"agricultural-science-pack", 1})
end

tech:commit()
