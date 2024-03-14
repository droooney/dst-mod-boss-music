local bossEvents = {
    ANCIENT_FUELWEAVER = {"stalker"},
    ANTLION = {"antlion"},
    BEE_QUEEN = {"beequeen"},
    CELESTIAL_CHAMPION = {"alterguardian_phase1", "alterguardian_phase2", "alterguardian_phase3"},
    CRAB_KING = {"crabking"},
    DRAGONFLY = {"dragonfly"},
    EYE_OF_TERROR = {"eyeofterror"},
    FROSTJAW = {"sharkboi"},
    KLAUS = {"klaus"},
    LUNAR_MUTATED_BOSSES = {"gestaltmutant"},
    MALBATROSS = {"malbatross"},
    NIGHTMARE_WEREPIG = {"daywalker"},
    SHADOW_PIECES = {"shadowchess"},
    TOADSTOOL = {"toadstool"},
}

local bossesTimeouts = {
    alterguardian_phase1 = 15,
    alterguardian_phase2 = 15,
}

local playingMusic = false
local stopMusicTask

function includes(array, item)
    for _, v in ipairs(array) do
        if v == item then
            return true
        end
    end

    return false
end

function findBoss(bossEvent)
    for boss, events in pairs(bossEvents) do
        if includes(events, bossEvent) then
            return boss
        end
    end
end

function startBossMusic()
    playingMusic = true

    GLOBAL.TheMixer:SetLevel("set_music", GetModConfigData("BOSS_VOLUME") / 10)
end

function stopBossMusic()
    playingMusic = false

    local _, _, musicLevel = GLOBAL.Profile:GetVolume()

    GLOBAL.TheMixer:SetLevel("set_music", musicLevel / 10)
end

AddPlayerPostInit(function (inst)
    inst:ListenForEvent("triggeredevent", function (_, data)
        local bossName = data.name
        local boss = findBoss(bossName)

        if not boss or not GetModConfigData("BOSS_" .. boss) then
            return
        end

        if not playingMusic then
            startBossMusic(bossName)
        end

        if stopMusicTask then
            stopMusicTask:Cancel()
        end

        stopMusicTask = inst:DoTaskInTime(bossesTimeouts[bossName] or 3, function ()
            stopBossMusic(bossName)
        end)
    end)
end)
