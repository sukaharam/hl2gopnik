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
    ["global_newgame_template_base_items"] = true,
    ["global_newgame_template_local_items"] = true,
    ["global_newgame_template_ammo"] = true,
    ["player_items_template"] = true,	
    
    ["relationship_turret_vs_combine_hate"] = true,
    ["relationship_turret_vs_alyx_like"] = true,
    ["relationship_turret_vs_manhack_hate"] = true,
    ["relationship_combine_vs_turret_hate"] = true,
    ["relationship_alyx_vs_turret_like"] = true,
    ["relationship_turret_vs_player_like"] = true,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        ents.WaitForEntityByName("turret_buddy", function(ent)
            ent:SetKeyValue("spawnflags", "576")
        end, true)

        -- 1680.254639 -3440.008301 -679.968750
        local checkpoint3 = GAMEMODE:CreateCheckpoint(Vector(1680.254639, -3440.008301, -679.968750), Angle(0, -90, 0))
        local checkpointTrigger3 = ents.Create("trigger_once")
        checkpointTrigger3:SetupTrigger(
            Vector(1680.254639, -3440.008301, -679.968750),
            Angle(0, 0, 0),
            Vector(-50, -50, 0),
            Vector(50, 50, 100)
        )
        checkpointTrigger3.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint3, activator)
        end

        -- 4161.470215 -3967.863525 -543.968750
        local checkpoint5 = GAMEMODE:CreateCheckpoint(Vector(4779.625488, -4233.572266, -543.968750), Angle(0, 180, 0))
        checkpoint5:SetVisiblePos(Vector(4137.396973, -3976.567871, -543.968750))
        local checkpointTrigger5 = ents.Create("trigger_once")
        checkpointTrigger5:SetupTrigger(
            Vector(4161.470215, -3967.863525, -543.968750),
            Angle(0, 0, 0),
            Vector(-180, -100, 0),
            Vector(180, 100, 100)
        )
        checkpointTrigger5.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint5, activator)
        end)

    end
end

function MAPSCRIPT:OnMapTransition()

    DbgPrint("OnMapTransition")

    -- Make sure we have alyx around.
    util.RunDelayed(function()
        local foundBarney = false
        for k,v in pairs(ents.FindByName("alyx")) do
            foundBarney = true
            break
        end
        if foundBarney == false then
            ents.WaitForEntityByName("alyx_template", function(ent)
                ent:Fire("ForceSpawn")
            end)
        end
    end, CurTime() + 0.1)

end

function MAPSCRIPT:PreChangelevel(map, landmark)



end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
