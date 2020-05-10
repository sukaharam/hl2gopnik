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
}

MAPSCRIPT.ImportantPlayerNPCNames =
{
    ["warehouse_citizen_jacobs"] = true,
    ["warehouse_citizen"] = true,
    ["warehouse_citizen_leon"] = true,
    ["warehouse_nurse"] = true,
    ["winston"] = true,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        -- -6381.103027 8103.064453 896.031250
        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(-6533.443848, 8131.516602, 896.031250), Angle(0, 0, 0))
        checkpoint1:SetVisiblePos(Vector(-6447.585449, 8024.932129, 896.031250))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(-6381.103027, 8103.064453, 896.031250),
            Angle(0, 0, 0),
            Vector(-100, -300, 0),
            Vector(100, 300, 170)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- -3500.986816 7756.634766 896.031250
        local checkpoint2 = GAMEMODE:CreateCheckpoint(Vector(-4065.605957, 7748.239258, 896.032776), Angle(3.366, 19.338, 0.000))
        checkpoint2:SetVisiblePos(Vector(-3477.525879, 7750.378906, 896.031250))
        local checkpointTrigger2 = ents.Create("trigger_once")
        checkpointTrigger2:SetupTrigger(
            Vector(-3500.986816, 7756.634766, 896.031250),
            Angle(0, 0, 0),
            Vector(-25, -100, 0),
            Vector(25, 100, 170)
        )
        checkpointTrigger2.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint2, activator)
        end

        -- Checkpoint
        -- -1123.785400 10358.985352 896.031250
        local checkpoint3 = GAMEMODE:CreateCheckpoint(Vector(-1098.884766, 10457.261719, 896.031250), Angle(0, -180, 0.000))
        local checkpointTrigger3 = ents.Create("trigger_once")
        checkpointTrigger3:SetupTrigger(
            Vector(-1123.785400, 10358.985352, 896.031250),
            Angle(0, 0, 0),
            Vector(-100, -25, 0),
            Vector(100, 25, 170)
        )
        checkpointTrigger3.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint3, activator)
        end

    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
