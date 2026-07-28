local khaoslib_item = require("__khaoslib__.prototypes.item")

--- @diagnostic disable-next-line: missing-fields
--- @type AttackParameters.projectile
local attack_parameters = {
  ammo_category = "mds-ballistic-missile",
  cooldown = math.max(1, 60 / settings.startup["mds-ballistic-shots-per-second"].value),
  range = settings.startup["mds-ballistic-max-range"].value --[[@as integer]],
  min_range = settings.startup["mds-ballistic-minimum-range"].value --[[@as integer]],
  sound = {{filename = "__base__/sound/fight/rocket-launcher.ogg", volume = 0.75}},
  projectile_center = {0, -1.6},
  projectile_creation_distance = 1.4,
}

khaoslib_item.copy("gun", "artillery-wagon-cannon", "mds-ballistic-artillery-gun")
  :set {
    localised_name = {"item-name.ballistic-missile-defense-system"},
    attack_parameters = attack_parameters,
  }
  :unset("attack_parameters.shell_particle")
  :unset("attack_parameters.projectile_creation_parameters")
  :commit()
