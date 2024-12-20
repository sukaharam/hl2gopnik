if SERVER then
    AddCSLuaFile()
end

local DbgPrint = print
local GAMETYPE = {}
GAMETYPE.Name = "Life-Half 2"
GAMETYPE.BaseGameType = "lambda_base"
GAMETYPE.MapScript = {}
GAMETYPE.PlayerSpawnClass = "info_player_start"
GAMETYPE.UsingCheckpoints = true
GAMETYPE.WaitForPlayers = true
GAMETYPE.MapList = {"d3_breen_01_b", "d3_citadel_05_b", "d3_citadel_04_b", "d3_citadel_03_b", "d3_citadel_02_b", "d3_citadel_01_b", "d3_c17_13_b", "d3_c17_12b_b", "d3_c17_12_b", "d3_c17_11_b", "d3_c17_10b_b", "d3_c17_10a_b", "d3_c17_09_b", "d3_c17_08_b", "d3_c17_07_b", "d3_c17_06b_b", "d3_c17_06a_b", "d3_c17_05_b", "d3_c17_04_b", "d3_c17_03_b", "d3_c17_02_b", "d3_c17_01_b", "d2_prison_08_b", "d2_prison_07_b", "d2_prison_06_b", "d2_prison_05_b", "d2_prison_04_b", "d2_prison_03_b", "d2_prison_02_b", "d2_prison_01_b", "d2_coast_12_b", "d2_coast_11_b", "d2_coast_10_b", "d2_coast_09_b", "d2_coast_07_b", "d2_coast_05_b", "d2_coast_04_b", "d2_coast_03_b", "d2_coast_01_b", "d1_town_05_b", "d1_town_04_b", "d1_town_02a_b", "d1_town_02_b", "d1_town_01a_b", "d1_town_01_b", "d1_eli_01_b", "d1_canals_13_b", "d1_canals_12_b", "d1_canals_11_b", "d1_canals_10_b", "d1_canals_09_b", "d1_canals_08_b", "d1_canals_07_b", "d1_canals_06_b", "d1_canals_05_b", "d1_canals_03_b", "d1_canals_02_b", "d1_canals_01a_b", "d1_canals_01_b", "d1_trainstation_06_b", "d1_trainstation_05_b", "d1_trainstation_04_b", "d1_trainstation_03_b", "d1_trainstation_02_b", "d1_trainstation_01_b" }

GAMETYPE.ClassesEnemyNPC = {
    ["npc_metropolice"] = true,
    ["npc_combine"] = true,
    ["npc_combine_s"] = true,
    ["npc_zombie"] = true,
    ["npc_fastzombie"] = true,
    ["npc_poisonzombie"] = true,
    ["npc_headcrab"] = true,
    ["npc_sniper"] = true,
    ["npc_strider"] = true,
    ["npc_headcrab_fast"] = true,
    ["npc_headcrab_black"] = true,
    ["npc_manhack"] = true,
    ["npc_cscanner"] = true,
    ["npc_clawscanner"] = true,
    ["npc_helicopter"] = true,
    ["npc_combinedropship"] = true,
    ["npc_combinegunship"] = true,
	["npc_cranedriver"] = true
}

GAMETYPE.DefaultGlobalState = {
    ["gordon_precriminal"] = GLOBAL_OFF,
    ["gordon_invulnerable"] = GLOBAL_OFF,
	["antlion_allied"] = GLOBAL_OFF,
    ["super_phys_gun"] = GLOBAL_OFF,
    ["friendly_encounter"] = GLOBAL_OFF
}

GAMETYPE.ImportantPlayerNPCClasses = {
    ["npc_alyx"] = true,
    ["npc_barney"] = true,
    ["npc_odessa"] = false,
    ["npc_kleiner"] = true,
    ["npc_dog"] = true,
    ["npc_eli"] = true,
    ["npc_mossman"] = false,
    ["npc_monk"] = true,
    ["npc_breen"] = false
}

GAMETYPE.CampaignNames = {

}

GAMETYPE.Settings = {}

function GAMETYPE:GetPlayerRespawnTime()
    local timeout = math.Clamp(GAMEMODE:GetSetting("max_respawn_timeout"), -1, 255)
    if timeout == -1 then
        return timeout
    end
    local alive = #team.GetPlayers(LAMBDA_TEAM_ALIVE)
    local total = player.GetCount() - 1

    if total <= 0 then
        total = 1
    end

    local timeoutAmount = math.Round(alive / total * timeout)

    return timeoutAmount
end

function GAMETYPE:ShouldRestartRound()
    local playerCount = 0
    local aliveCount = 0


    -- Collect how many players exist and how many are alive, in case they are all dead
    -- we have to restart the round.
    for _, ply in pairs(player.GetAll()) do
        if ply:Alive() then
            aliveCount = aliveCount + 1
        end

        playerCount = playerCount + 1
    end

    if playerCount > 0 and aliveCount == 0 then
        DbgPrint("All players are dead, restart required")

        return true
    end

    return false
end

function GAMETYPE:PlayerCanPickupWeapon(ply, wep)
    local class = wep:GetClass()

    if class == "weapon_frag" then
        if ply:HasWeapon(class) and ply:GetAmmoCount("grenade") >= sk_max_grenade:GetInt() then return false end
    elseif class == "weapon_annabelle" then
        return false -- Not supposed to have this.
    end

    if ply:HasWeapon(wep:GetClass()) == true then
        -- Only allow a new pickup once if there is ammo in the weapon.
        if wep:GetPrimaryAmmoType() == -1 and wep:GetSecondaryAmmoType() == -1 then return false end

        return ply.ObjectPickupTable[wep.UniqueEntityId] ~= true
    end

    return true
end

function GAMETYPE:PlayerCanPickupItem(ply, item)
    return true
end

function GAMETYPE:GetWeaponRespawnTime()
    return 0.5
end

function GAMETYPE:GetItemRespawnTime()
    return -1
end

function GAMETYPE:ShouldRespawnWeapon(ent)
    if ent:IsItem() == true or ent.DroppedByPlayerDeath == true then return false end

    return true
end

function GAMETYPE:PlayerDeath(ply, inflictor, attacker)
    ply:AddDeaths(1)

    -- Suicide?
    if inflictor == ply or attacker == ply then
        attacker:AddFrags(-1)

        return
    end

    -- Friendly kill?
    if IsValid(attacker) and attacker:IsPlayer() then
        attacker:AddFrags(-1)
    elseif IsValid(inflictor) and inflictor:IsPlayer() then
        inflictor:AddFrags(-1)
    end
end

function GAMETYPE:PlayerShouldTakeDamage(ply, attacker, inflictor)
    local playerAttacking = (IsValid(attacker) and attacker:IsPlayer()) or (IsValid(inflictor) and inflictor:IsPlayer())
    -- Friendly fire is controlled by convar in this case.
    if playerAttacking == true and GAMEMODE:GetSetting("friendlyfire") == false then return false end

    return true
end

function GAMETYPE:CanPlayerSpawn(ply, spawn)
    return true
end

function GAMETYPE:ShouldRespawnItem(ent)
    return false
end

function GAMETYPE:PlayerSelectSpawn(spawns)
    for k, v in pairs(spawns) do
        if v.MasterSpawn == true then return v end
    end

    for k, v in pairs(spawns) do
        if v:HasSpawnFlags(1) == true then return v end
    end

    return spawns[1]
end

function GAMETYPE:GetPlayerLoadout()
    return self.MapScript.DefaultLoadout or {
        Weapons = {"weapon_lambda_medkit", "weapon_crowbar", "weapon_pistol", "weapon_smg1", "weapon_357", "weapon_physcannon", "weapon_frag", "weapon_shotgun", "weapon_ar2", "weapon_rpg", "weapon_crossbow"},
        Ammo = {
            ["Pistol"] = 20,
            ["SMG1"] = 45,
            ["357"] = 6,
            ["Grenade"] = 3,
            ["Buckshot"] = 12,
            ["AR2"] = 50,
            ["RPG_Round"] = 8,
            ["SMG1_Grenade"] = 3,
            ["XBowBolt"] = 4
        },
        Armor = 60,
        HEV = true
    }
end

function GAMETYPE:LoadCurrentMapScript()
    self.Base.LoadMapScript(self, "lh2", game.GetMap():lower())
end

function GAMETYPE:LoadLocalisation(lang, gmodLang)
end

function GAMETYPE:AllowPlayerTracking()
    return GAMEMODE:GetSetting("player_tracker")
end

function GAMETYPE:GetDifficultyData()
    return {
        [0] = {
            Name = "Very Easy",
            Proficiency = WEAPON_PROFICIENCY_POOR,
            Skill = 1,
            NPCSpawningScale = 0.0,
            DamageScale = {
                [DMG_SCALE_PVN] = 1.6,
                [DMG_SCALE_NVP] = 0.7,
                [DMG_SCALE_PVP] = 1,
                [DMG_SCALE_NVN] = 1
            },
            HitgroupPlayerDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 2.5,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            },
            HitgroupNPCDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 2.5,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            }
        },
        [1] = {
            Name = "Easy",
            Proficiency = WEAPON_PROFICIENCY_AVERAGE,
            Skill = 1,
            NPCSpawningScale = 0.2,
            DamageScale = {
                [DMG_SCALE_PVN] = 1.2,
                [DMG_SCALE_NVP] = 0.8,
                [DMG_SCALE_PVP] = 1,
                [DMG_SCALE_NVN] = 1
            },
            HitgroupPlayerDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 3.4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            },
            HitgroupNPCDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 3.4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            }
        },
        [2] = {
            Name = "Normal",
            Proficiency = WEAPON_PROFICIENCY_GOOD,
            Skill = 2,
            NPCSpawningScale = 0.3,
            DamageScale = {
                [DMG_SCALE_PVN] = 1,
                [DMG_SCALE_NVP] = 1,
                [DMG_SCALE_PVP] = 1,
                [DMG_SCALE_NVN] = 1
            },
            HitgroupPlayerDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            },
            HitgroupNPCDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            }
        },
        [3] = {
            Name = "Hard",
            Proficiency = WEAPON_PROFICIENCY_VERY_GOOD,
            Skill = 2,
            NPCSpawningScale = 0.7,
            DamageScale = {
                [DMG_SCALE_PVN] = 1,
                [DMG_SCALE_NVP] = 1,
                [DMG_SCALE_PVP] = 1,
                [DMG_SCALE_NVN] = 1
            },
            HitgroupPlayerDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            },
            HitgroupNPCDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            }
        },
        [4] = {
            Name = "Very Hard",
            Proficiency = WEAPON_PROFICIENCY_PERFECT,
            Skill = 3,
            NPCSpawningScale = 1,
            DamageScale = {
                [DMG_SCALE_PVN] = 1,
                [DMG_SCALE_NVP] = 1,
                [DMG_SCALE_PVP] = 1,
                [DMG_SCALE_NVN] = 1
            },
            HitgroupPlayerDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            },
            HitgroupNPCDamageScale = {
                [HITGROUP_GENERIC] = 1,
                [HITGROUP_HEAD] = 4,
                [HITGROUP_CHEST] = 1,
                [HITGROUP_STOMACH] = 1,
                [HITGROUP_LEFTARM] = 1,
                [HITGROUP_RIGHTARM] = 1,
                [HITGROUP_LEFTLEG] = 1,
                [HITGROUP_RIGHTLEG] = 1
            }
        },
        [5] = {
            Name = "Realism",
            Proficiency = WEAPON_PROFICIENCY_PERFECT,
            Skill = 3,
            NPCSpawningScale = 1,
            DamageScale = {
                [DMG_SCALE_PVN] = 1,
                [DMG_SCALE_NVP] = 1,
                [DMG_SCALE_PVP] = 1,
                [DMG_SCALE_NVN] = 1
            },
            HitgroupPlayerDamageScale = {
                [HITGROUP_GENERIC] = 2,
                [HITGROUP_HEAD] = 8,
                [HITGROUP_CHEST] = 3.5,
                [HITGROUP_STOMACH] = 3,
                [HITGROUP_LEFTARM] = 0.8,
                [HITGROUP_RIGHTARM] = 0.8,
                [HITGROUP_LEFTLEG] = 0.8,
                [HITGROUP_RIGHTLEG] = 0.8
            },
            HitgroupNPCDamageScale = {
                [HITGROUP_GENERIC] = 2,
                [HITGROUP_HEAD] = 8,
                [HITGROUP_CHEST] = 3.5,
                [HITGROUP_STOMACH] = 3,
                [HITGROUP_LEFTARM] = 0.8,
                [HITGROUP_RIGHTARM] = 0.8,
                [HITGROUP_LEFTLEG] = 0.8,
                [HITGROUP_RIGHTLEG] = 0.8
            }
        }
    }
end

function GAMETYPE:InitSettings()
    self.Base.InitSettings(self)

    GAMEMODE:AddSetting("dynamic_checkpoints", {
        Category = "SERVER",
        NiceName = "#GM_DYNCHECKPOINT",
        Description = "Dynamic checkpoints",
        Type = "bool",
        Default = true,
        Flags = bit.bor(0, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED),
    })

    GAMEMODE:AddSetting("allow_npcdmg", {
        Category = "SERVER",
        NiceName = "#GM_NPCDMG",
        Description = "Friendly NPC damage",
        Type = "bool",
        Default = true,
        Flags = bit.bor(0, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED),
    })

    GAMEMODE:AddSetting("player_tracker", {
        Category = "SERVER",
        NiceName = "#GM_PLYTRACK",
        Description = "Player tracking",
        Type = "bool",
        Default = true,
        Flags = bit.bor(0, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED),
    })

    GAMEMODE:AddSetting("friendly_antlion_collision", {
        Category = "SERVER",
        NiceName = "#GM_ANTLIONCOLLISION",
        Description = "Friendly Antlion collision",
        Type = "bool",
        Default = false,
        Flags = bit.bor(0, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED),
    })

end

function GAMETYPE:GetCampaignName(map)
    local curMap = GAMEMODE:GetCurrentMap()
    local n = GAMEMODE:GetMapIndex(GAMEMODE:GetPreviousMap(), curMap)

    for k, v in pairs(self.CampaignNames) do
        if n >= v.s and n <= v.e then return k end
    end
end

function GAMETYPE:GetScoreboardInfo()
    local scoreboardInfo = {
        {
            name = "LAMBDA_Map",
            value = game.GetMap()
        }
    }

    local campaign = self:GetCampaignName(GAMEMODE:GetCurrentMap())

    if campaign ~= nil then
        table.insert(scoreboardInfo, {
            name = "LAMBDA_Chapter",
            value = campaign
        })
    end

    return scoreboardInfo
end

hook.Add("LambdaLoadGameTypes", "LH2GameType", function(gametypes)
    gametypes:Add("lh2", GAMETYPE)
end)