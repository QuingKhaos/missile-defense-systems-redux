local khaoslib_entity = require("__khaoslib__.prototypes.entity")

khaoslib_entity.copy("artillery-flare", "artillery-flare", "mds-ballistic-flare")
  :set {
    shot_category = "mds-ballistic-missile",
    shots_per_flare = 1000000,
    life_time = 4 * minute,
    early_death_ticks = 5,
  }
  :commit()
