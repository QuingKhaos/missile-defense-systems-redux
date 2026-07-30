local khaoslib_ammo = require("__khaoslib__.prototypes.ammo")
local khaoslib_technology = require("__khaoslib__.prototypes.technology")

if mods["khaosammogroup"] then
  local ballistic_missiles = khaoslib_ammo.find(function(ammo)
    return ammo.ammo_category == "mds-ballistic-missile"
  end)

  for _, ammo_name in pairs(ballistic_missiles) do
    khaoslib_ammo:load(ammo_name):set {subgroup = "ammo-rocket"} :commit()
  end
end

-- Parity with rocket damage and speed research
local techs = khaoslib_technology.find(function(tech)
  return khaoslib_technology.has_effect(tech, function(effect)
      return (effect.type == "ammo-damage" or effect.type == "gun-speed") and effect.ammo_category == "rocket"
    end)
end)

for _, tech_name in pairs(techs) do
  local tech = khaoslib_technology:load(tech_name)
  local effects = tech:find_effects(function(effect)
    return (effect.type == "ammo-damage" or effect.type == "gun-speed") and effect.ammo_category == "rocket"
  end)

  for _, effect in pairs(effects) do
    effect.ammo_category = "mds-ballistic-missile"
    tech:add_effect(effect)
  end

  tech:commit()
end
