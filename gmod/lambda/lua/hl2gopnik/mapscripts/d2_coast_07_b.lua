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
    ["player_spawn_items_maker"] = true,
	["player_items_template"] = true,
	["jeep_template"] = true,
}

MAPSCRIPT.VehicleGuns = true

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        
        -- Workaround: Make sure we let the dropship fly off, atm theres lua way to tell the contents of a specific model shape.
        -- 3031.886963 5218.268066 1532.155762
        local hackTrigger1 = ents.Create("trigger_once")
        hackTrigger1:SetupTrigger(
            Vector(3031.886963, 5218.268066, 1532.155762),
            Angle(0, 0, 0),
            Vector(-150, -80, 0),
            Vector(150, 80, 100)
        )
        hackTrigger1.OnTrigger = function()
            TriggerOutputs({
                {"dropship", "Activate", 0.0, ""},
            })
        end

    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
