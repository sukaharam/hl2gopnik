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
        "weapon_physcannon",
    },
    Ammo =
    {
    },
    Armor = 80,
    HEV = true,
}

MAPSCRIPT.InputFilters =
{
 
}

MAPSCRIPT.EntityFilterByClass =
{

}

MAPSCRIPT.EntityFilterByName =
{
    ["player_items_template"] = true,
}

MAPSCRIPT.GlobalStates =
{
    ["super_phys_gun"] = GLOBAL_ON,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        --breen's office checkpoint
        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(-1968, 224, 624), Angle(0, 45, 0))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(-1968, -160, 584),
            Angle(0, 0, 0),
            Vector(-64, -64, 0),
            Vector(64, 64, 128)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end
	
    end

end

return MAPSCRIPT
