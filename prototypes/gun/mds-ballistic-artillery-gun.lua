local khaoslib_item = require("__khaoslib__.prototypes.item")

khaoslib_item.copy("gun", "artillery-wagon-cannon", "mds-ballistic-artillery-gun")
  :set {
    localised_name = {"item-name.ballistic-missile-defense-system"},
    attack_parameters = {
      ammo_category = "mds-ballistic-missile",
      cooldown = math.max(1, 60 / settings.startup["mds-ballistic-shots-per-second"].value),
      range = settings.startup["mds-ballistic-max-range"].value --[[@as integer]],
      min_range = settings.startup["mds-ballistic-minimum-range"].value --[[@as integer]],
      sound = {{filename = "__base__/sound/fight/rocket-launcher.ogg", volume = 0.75}},
    }
  }
  :unset("attack_parameters.shell_particle")
  :commit()
