local khaoslib_entity = require("__khaoslib__.prototypes.entity")

khaoslib_entity.copy("artillery-turret", "artillery-turret", "ballistic-missile-defense-system")
  :set {
    gun = "mds-ballistic-artillery-gun",
    localised_name = {"item-name.ballistic-missile-defense-system"},
    max_health = 1200,
    turret_rotation_speed = 0.0015,
    turn_after_shooting_cooldown = 20,
    ammo_stack_limit = 10,
    manual_range_modifier = 1,
    corpse = "big-remnants",
    collision_box = {{-2, -2}, {2, 2.5}},
    selection_box = {{-2, -2}, {2, 2.5}},
  }
  :unset("rotating_sound")
  :unset("base_picture")
  :unset("cannon_base_pictures")
  :unset("cannon_barrel_pictures")
  :unset("cannon_barrel_recoil_shiftings")
  :unset("cannon_barrel_recoil_shiftings_load_correction_matrix")
  :unset("cannon_barrel_light_direction")
  :unset("cannon_parking_frame_count")
  :unset("cannon_parking_speed")
  :unset("water_reflection")
  :set {
    cannon_base_shift = {0, 0, 0},
    cannon_base_pictures = {
      layers = {
        {
          filename = "__missile-defense-systems-redux__/graphics/entity/ballistic-defense-system.png",
          priority = "medium",
          scale = 0.3,
          width = 512,
          height = 512,
          direction_count = 64,
          line_length = 8,
          axially_symmetrical = false,
          shift = {0, 0},
        },
        {
          filename = "__missile-defense-systems-redux__/graphics/entity/ballistic-defense-system-shadow.png",
          priority = "medium",
          scale = 0.3,
          width = 512,
          height = 512,
          direction_count = 64,
          line_length = 8,
          axially_symmetrical = false,
          shift = util.by_pixel(64, 0),
          draw_as_shadow = true,
        },
      },
    }
  }
  :set_minable {mining_time = 1, result = "ballistic-missile-defense-system"}
  :set_icons {{icon = "__missile-defense-systems-redux__/graphics/icons/ballistic-missile-defense-system.png", icon_size = 64}}
  :commit()
