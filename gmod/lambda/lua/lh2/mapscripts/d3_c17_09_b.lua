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

        -- 7099.762695 6237.561523 0.031250
        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(7405.353516, 6305.318848, 0.031250), Angle(0, 180, 0))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(7099.762695, 6237.561523, 0.031250),
            Angle(0, 0, 0),
            Vector(-130, -130, 0),
            Vector(130, 130, 100)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- 6000.681641 6446.313477 96.031250
        local checkpoint2 = GAMEMODE:CreateCheckpoint(Vector(6000.681641, 6446.313477, 96.031250), Angle(0, 0, 0))
        local checkpointTrigger2 = ents.Create("trigger_once")
        checkpointTrigger2:SetupTrigger(
            Vector(6000.681641, 6446.313477, 96.031250),
            Angle(0, 0, 0),
            Vector(-130, -130, 0),
            Vector(130, 130, 100)
        )
        checkpointTrigger2.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint2, activator)
        end

    end

end

function MAPSCRIPT:OnMapTransition()

    DbgPrint("OnMapTransition")

    -- Make sure we have barney around.
    util.RunDelayed(function()
        local foundBarney = false
        for k,v in pairs(ents.FindByName("barney")) do
            foundBarney = true
            break
        end
        if foundBarney == false then
            ents.WaitForEntityByName("barney_template", function(ent)
                ent:Fire("ForceSpawn")
            end)
        end
    end, CurTime() + 0.1)

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
