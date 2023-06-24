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
