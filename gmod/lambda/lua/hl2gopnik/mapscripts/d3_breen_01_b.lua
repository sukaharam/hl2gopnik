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
    -- ["pod"] = { "EnterVehicleImmediate" }
}

MAPSCRIPT.EntityFilterByClass =
{
    --["env_global"] = true,
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
