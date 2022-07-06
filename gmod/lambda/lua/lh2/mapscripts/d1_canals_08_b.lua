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
}

MAPSCRIPT.EntityFilterByClass =
{
    --["env_global"] = true,
}

MAPSCRIPT.EntityFilterByName =
{
    ["player_items_template"] = true,
	["template_airboat"] = true,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(-486.748169, -329.674469, -591.968750), Angle(0, 90, 0))
        checkpoint1:SetVisiblePos(Vector(-420.171631, -97.050110, -591.968750))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(-480.402649, -58.779499, -575.968750),
            Angle(0, 0, 0),
            Vector(-100, -100, 0),
            Vector(100, 100, 180)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetVehicleCheckpoint(Vector(53.214970, -102.730621, -615.638123), Angle(0, -180, 0))
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- -841.505310 -1408.689331 -382.968750
        local checkpoint2 = GAMEMODE:CreateCheckpoint(Vector(-841.505310, -1408.689331, -382.968750), Angle(0, 90, 0))
        local checkpointTrigger2 = ents.Create("trigger_once")
        checkpointTrigger2:SetupTrigger(
            Vector(-841.505310, -1408.689331, -382.968750),
            Angle(0, 0, 0),
            Vector(-100, -100, 0),
            Vector(100, 100, 180)
        )
        checkpointTrigger2.OnTrigger = function(_, activator)
            --GAMEMODE:SetVehicleCheckpoint(Vector(53.214970, -102.730621, -615.638123), Angle(0, -180, 0))
            GAMEMODE:SetPlayerCheckpoint(checkpoint2, activator)
        end

    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
