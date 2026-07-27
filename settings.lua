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

khaoslib_setting:load {
  type = "string-setting",
  name = "mds-advanced-fire-pattern",
  setting_type = "startup",
  default_value = "arc",
  allowed_values = {"arc", "circle"},
  order = "a[settings]-b[advanced]-a[fire-pattern]",
} :commit()

khaoslib_setting:load {
  type = "int-setting",
  name = "mds-advanced-fire-arc-degree",
  setting_type = "startup",
  default_value = 55,
  minimum_value = 1,
  maximum_value = 180,
  order = "a[settings]-b[advanced]-b[fire-arc-degree]",
} :commit()

khaoslib_setting:load {
  type = "int-setting",
  name = "mds-advanced-min-range",
  setting_type = "startup",
  default_value = 40,
  minimum_value = 0,
  maximum_value = 100,
  order = "a[settings]-b[advanced]-c[min-range]",
} :commit()

khaoslib_setting:load {
  type = "int-setting",
  name = "mds-advanced-max-range",
  setting_type = "startup",
  default_value = 80,
  minimum_value = 0,
  maximum_value = 100,
  order = "a[settings]-b[advanced]-d[max-range]",
} :commit()

khaoslib_setting:load {
    type = "double-setting",
    name = "mds-advanced-fire-rate",
    setting_type = "startup",
    default_value = 0.5,
    minimum_value = 0.1,
    maximum_value = 10.0,
    order = "a[settings]-b[advanced]-e[fire-rate]",
} :commit()

khaoslib_setting:load {
  type = "double-setting",
  name = "mds-ballistic-shots-per-second",
  setting_type = "startup",
  default_value = 6.0,
  minimum_value = 0.1,
  maximum_value = 20.0,
  order = "a[settings]-c[ballistic]-a[shots-per-second]",
} :commit()

khaoslib_setting:load {
  name = "mds-ballistic-minimum-range",
  type = "int-setting",
  setting_type= "startup",
  default_value = 80,
  minimum_value = 0,
  maximum_value = 500,
  order = "a[settings]-c[ballistic]-b[minimum-range]",
} :commit()

khaoslib_setting:load {
  name = "mds-ballistic-max-range",
  type = "int-setting",
  setting_type= "startup",
  default_value = 500,
  minimum_value = 0,
  maximum_value = 1500,
  order = "a[settings]-c[ballistic]-c[max-range]",
} :commit()
