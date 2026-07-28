local shortcut = util.table.deepcopy(data.raw["shortcut"]["give-artillery-targeting-remote"])
shortcut.name = "give-mds-ballistic-targeting-remote"
shortcut.localised_name = {"shortcut.give-mds-ballistic-targeting-remote"}
shortcut.item_to_spawn = "mds-ballistic-targeting-remote"
shortcut.technology_to_unlock = "ballistic-missile-defense-system"
shortcut.unavailable_until_unlocked = true
shortcut.order = (shortcut.order or "zz") .. "-mds-b"

data:extend {shortcut}
