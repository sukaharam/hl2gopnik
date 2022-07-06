AddCSLuaFile()

local DbgPrint = GetLogging("MapScript")
local MAPSCRIPT = {}

MAPSCRIPT.PlayersLocked = true
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
    Armor = 100,
    HEV = true,
}

MAPSCRIPT.InputFilters =
{

}

MAPSCRIPT.GlobalStates =
{
    ["super_phys_gun"] = GLOBAL_OFF,
}

MAPSCRIPT.EntityFilterByClass =
{
    --["env_global"] = true,
}

MAPSCRIPT.EntityFilterByName =
{
    ["global_newgame_template_base_items"] = true,
    ["global_newgame_template_local_items"] = true,
	["player_items_template"] = true,
}

function MAPSCRIPT:Init()

    self.PlayerQueue = {}

end


function MAPSCRIPT:Think()


end

function MAPSCRIPT:PostInit()

    if SERVER then


    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)



end

return MAPSCRIPT