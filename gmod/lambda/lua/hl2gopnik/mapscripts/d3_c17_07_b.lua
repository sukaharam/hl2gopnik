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

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        -- 5487.663574 1408.772949 0.031250 10.626 -1.579 0.000
        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(5329.144043, 1568.602905, 0.031250), Angle(0, 0, 0))
        checkpoint1:SetVisiblePos(Vector(6280.843262, 1534.321655, 167.015106))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(6535.159668, 1535.497437, 50.049042),
            Angle(0, 0, 0),
            Vector(-500, -500, 0),
            Vector(500, 500, 150)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- New trigger to close the gate.
        local checkpoint3 = GAMEMODE:CreateCheckpoint(Vector(7399.153809, 1336.154907, 0.031250), Angle(0, 0, 0))
        checkpoint3:SetVisiblePos(Vector(7426.479004, 1531.018311, -3.968750))
        local checkpointTrigger2 = ents.Create("trigger_once")
        checkpointTrigger2:SetupTrigger(
            Vector(8031.499512, 1544.012939, -3.968811),
            Angle(0, 0, 0),
            Vector(-680, -1000, -600),
            Vector(2600, 1600, 200)
        )
        checkpointTrigger2:SetKeyValue("teamwait", "1")
        checkpointTrigger2.OnTrigger = function(ent)
            TriggerOutputs({
                {"gate_close_counter", "Add", 0, "1"},
            })
            GAMEMODE:SetPlayerCheckpoint(checkpoint3)
        end

    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
