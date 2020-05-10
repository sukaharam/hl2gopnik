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
}

MAPSCRIPT.ImportantPlayerNPCNames =
{

}

MAPSCRIPT.VehicleGuns = true

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()


    if SERVER then


        -- In case of map reset.
        GAMEMODE:SetSpawnPlayerVehicles(true)

        -- This is ugly but it solves a strange issue where the whole script falls apart.
        local timer1 = ents.Create("logic_timer")
        timer1:SetKeyValue("RefireTime", "1")
        timer1:Fire("AddOutput", "OnTimer dropship_container,SetDamageFilter,lambda_null_filter,0,-1")
        timer1:Spawn()

        local nullFilter = ents.Create("filter_activator_class")
        nullFilter:SetName("lambda_null_filter")
        nullFilter:SetKeyValue("filterclass", "null")
        nullFilter:Spawn()

        end
		
		local citizen_greeter
        ents.WaitForEntityByName("citizen_greeter", function(ent)
            ent.ImportantNPC = true
            citizen_greeter = ent
        end)

        GAMEMODE:WaitForInput("greeter_cover", "MoveToPosition", function(ent)
            DbgPrint("citizen_greeter no longer important NPC")
            if IsValid(citizen_greeter) then
                citizen_greeter.ImportantNPC = false
            end

        end)
		
    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
