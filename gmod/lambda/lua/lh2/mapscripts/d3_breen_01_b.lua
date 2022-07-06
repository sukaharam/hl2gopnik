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

function MAPSCRIPT:PostPlayerSpawn(ply)

    if self.AllowPhyscannon == true then
        ply:Give("weapon_physcannon")
    end

    if self.SpawnInPod == true and IsValid(ply:GetVehicle()) == false then

        DbgPrint("Player " .. tostring(ply) .. " has no vehicle, setting into empty pod...")
        for _,v in pairs(self.Pods) do
            if IsValid(v:GetDriver()) == false then
                DbgPrint("Putting player into vehicle " .. tostring(v))
                ply:EnterVehicle(v)
                break
            end
        end

    end

end

return MAPSCRIPT
