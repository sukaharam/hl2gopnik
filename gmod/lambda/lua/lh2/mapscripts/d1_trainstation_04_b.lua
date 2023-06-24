if SERVER then
    AddCSLuaFile()
end

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

}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    DbgPrint("PostInit")

    if SERVER then

        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(-5132.465332, -3575.130127, 698.892090), Angle(0, -180, 0))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(-5132.465332, -3575.130127, 698.892090),
            Angle(0,0,0),
            Vector(-200, -200, 0),
            Vector(200, 200, 100)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- -7176.394043 -3890.482178 384.031250
        local checkpoint3 = GAMEMODE:CreateCheckpoint(Vector(-7204.497070, -3997.591064, 384.031250), Angle(0, -180, 0))
        checkpoint3:SetVisiblePos(Vector(-7275.987793, -3983.696533, 384.031250))
        local checkpointTrigger3 = ents.Create("trigger_once")
        checkpointTrigger3:SetupTrigger(
            Vector(-7275.987793, -3983.696533, 384.031250),
            Angle(0,0,0),
            Vector(-50, -130, 0),
            Vector(160, 130, 100)
        )
        checkpointTrigger3.OnTrigger = function(trigger)
            GAMEMODE:SetPlayerCheckpoint(checkpoint3)
        end

    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
