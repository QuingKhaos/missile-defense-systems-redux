local khaoslib_setting = require("__khaoslib__.settings.setting")

khaoslib_setting:load {
  type = "string-setting",
  name = "mds-basic-fire-pattern",
  setting_type = "startup",
  default_value = "arc",
  allowed_values = {"arc", "circle"},
  order = "a[settings]-a[basic]-a[fire-pattern]",
} :commit()

khaoslib_setting:load {
  type = "int-setting",
  name = "mds-basic-fire-arc-degree",
  setting_type = "startup",
  default_value = 120,
  minimum_value = 1,
  maximum_value = 180,
  order = "a[settings]-a[basic]-b[fire-arc-degree]",
} :commit()

khaoslib_setting:load {
  type = "int-setting",
  name = "mds-basic-min-range",
  setting_type = "startup",
  default_value = 0,
  minimum_value = 0,
  maximum_value = 100,
  order = "a[settings]-a[basic]-c[min-range]",
} :commit()

khaoslib_setting:load {
  type = "int-setting",
  name = "mds-basic-max-range",
  setting_type = "startup",
  default_value = 40,
  minimum_value = 0,
  maximum_value = 100,
  order = "a[settings]-a[basic]-d[max-range]",
} :commit()

khaoslib_setting:load {
    type = "double-setting",
    name = "mds-basic-fire-rate",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.1,
    maximum_value = 10.0,
    order = "a[settings]-a[basic]-e[fire-rate]",
} :commit()
