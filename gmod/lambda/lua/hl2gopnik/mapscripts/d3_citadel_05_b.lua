AddCSLuaFile()

local DbgPrint = GetLogging("MapScript")
local MAPSCRIPT = {}

MAPSCRIPT.PlayersLocked = false
MAPSCRIPT.DefaultLoadout =
{
    Weapons =
    {
        "weapon_physcannon",
    },
    Ammo =
    {
    },
    Armor = 100,
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
    ["global_newgame_template_ammo"] = true,
    ["global_newgame_template_local_items"] = true,
    ["global_newgame_template_base_items"] = true,
	["player_items_template"] = true,
}

MAPSCRIPT.GlobalStates =
{
    ["super_phys_gun"] = GLOBAL_ON,
}

function MAPSCRIPT:Init()

end





function MAPSCRIPT:PostInit()


end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT