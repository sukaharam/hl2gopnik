AddCSLuaFile()

local DbgPrint = GetLogging("MapScript")
local MAPSCRIPT = {}

MAPSCRIPT.PlayersLocked = false
MAPSCRIPT.DefaultLoadout =
{
    Weapons =
    {
        "weapon_lambda_medkit",
        "weapon_crowbar",
        "weapon_pistol",
        "weapon_smg1",
        "weapon_357",
        "weapon_physcannon",
        "weapon_frag",
        "weapon_shotgun",
        "weapon_ar2",
        "weapon_rpg",
        "weapon_crossbow",
    },
    Ammo =
    {
        ["Pistol"] = 20,
        ["SMG1"] = 45,
        ["357"] = 6,
        ["Grenade"] = 3,
        ["Buckshot"] = 12,
        ["AR2"] = 50,
        ["RPG_Round"] = 8,
        ["SMG1_Grenade"] = 3,
        ["XBowBolt"] = 4,
    },
    Armor = 80,
    HEV = true,
}

MAPSCRIPT.InputFilters =
{
    ["station_cop_2"] = { "Kill" },
    ["station_cop_1"] = { "Kill" },
    ["station_cop_4"] = { "Kill" },

}

MAPSCRIPT.EntityFilterByClass =
{
    --["env_global"] = true,
}

MAPSCRIPT.EntityFilterByName =
{
    ["player_spawn_items"] = true,
	["player_items_template"] = true,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then


        -- Fix barney beeing strict about standing infront of him
        local scriptCond_seeBarney = ents.FindFirstByName("scriptCond_seeBarney")
        scriptCond_seeBarney:SetKeyValue("PlayerActorFOV", "-1")
        scriptCond_seeBarney:SetKeyValue("PlayerTargetLOS", "3")
        end

        -- Lets automatically scale some enemies.
        -- -7871.712891 -1510.040405 -63.968754
        local maker1 = ents.Create("npc_template_maker")
        maker1:SetPos(Vector(-8490.908203, -2256.173096, -63.968750))
        maker1:SetKeyValue("spawnflags", SF_NPCMAKER_HIDEFROMPLAYER + SF_NPCMAKER_ALWAYSUSERADIUS)
        maker1:SetKeyValue("StartDisabled", "1")
        maker1:SetKeyValue("TemplateName", "chaser_cop_1")
        maker1:SetKeyValue("MaxNPCCount", "2")
        maker1:SetKeyValue("MaxLiveChildren", "2")
        maker1:SetKeyValue("SpawnFrequency", "0.2")
        maker1:SetKeyValue("Radius", "800")
        maker1:Spawn()

        -- -8038.701660 -2541.850098 -63.968746
        local maker2 = ents.Create("npc_template_maker")
        maker2:SetPos(Vector(-8038.701660, -2541.850098, -63.968746))
        maker2:SetKeyValue("spawnflags", SF_NPCMAKER_HIDEFROMPLAYER + SF_NPCMAKER_ALWAYSUSERADIUS)
        maker2:SetKeyValue("StartDisabled", "1")
        maker2:SetKeyValue("TemplateName", "chaser_cop_1")
        maker2:SetKeyValue("MaxNPCCount", "2")
        maker2:SetKeyValue("MaxLiveChildren", "2")
        maker2:SetKeyValue("SpawnFrequency", "0.2")
        maker2:SetKeyValue("Radius", "800")
        maker2:Spawn()

        local maker3 = ents.Create("npc_template_maker")
        maker3:SetPos(Vector(-6699.455078, -1714.247314, -63.968750))
        maker3:SetKeyValue("spawnflags", SF_NPCMAKER_HIDEFROMPLAYER + SF_NPCMAKER_ALWAYSUSERADIUS)
        maker3:SetKeyValue("StartDisabled", "1")
        maker3:SetKeyValue("TemplateName", "chaser_cop_1")
        maker3:SetKeyValue("MaxNPCCount", "2")
        maker3:SetKeyValue("MaxLiveChildren", "2")
        maker3:SetKeyValue("SpawnFrequency", "0.2")
        maker3:SetKeyValue("Radius", "800")
        maker3:Spawn()

        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(-8169.935059, -3181.270508, 192.031250), Angle(0, 0, 0))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(-8169.935059, -3181.270508, 192.031250),
            Angle(0, 0, 0),
            Vector(-50, -50, 0),
            Vector(50, 50, 70)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
            maker1:Fire("Enable")
            maker2:Fire("Enable")
            maker3:Fire("Enable")
        end


    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
