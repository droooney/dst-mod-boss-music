name = "Boss Music"
description = "Changes music volume during boss fights and changes it back after the fight"
author = "jimmybaxter"
version = "1.0"
api_version = 10
dst_compatible = true
all_clients_require_mod = false
client_only_mod = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {}
forumthread = ""

function createBossOption(name, label)
    return {
        name = "BOSS_" .. name,
        label = label,
        options = {
            {data = true, description = "Enabled"},
            {data = false, description = "Disabled"},
        },
        default = true,
    }
end

local volumeOptions = {}

for i = 0, 10 do
    volumeOptions[i + 1] = {
        data = i,
        description = "" .. i,
    }
end

configuration_options = {
    {
        name = "BOSS_VOLUME",
        label = "Boss music volume",
        options = volumeOptions,
        default = 10,
    },

    {
        name = "",
        label = "Bosses",
        options = {{data = 0, description = ""}},
        default = 0,
        hover = "",
    },
    createBossOption("ANCIENT_FUELWEAVER", "Ancient Fuelweaver"),
    createBossOption("ANTLION", "Antlion"),
    createBossOption("BEE_QUEEN", "Bee Queen"),
    createBossOption("CELESTIAL_CHAMPION", "Celestial Champion"),
    createBossOption("CRAB_KING", "Crab King"),
    createBossOption("DRAGONFLY", "Dragonfly"),
    createBossOption("EYE_OF_TERROR", "Eye/Twins of Terror"),
    createBossOption("KLAUS", "Klaus"),
    createBossOption("MALBATROSS", "Malbatross"),
    createBossOption("SHADOW_PIECES", "Shadow Pieces"),
    createBossOption("TOADSTOOL", "Toadstool"),
}
