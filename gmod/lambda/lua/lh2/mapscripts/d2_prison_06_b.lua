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
}

MAPSCRIPT.GlobalStates =
{
    ["antlion_allied"] = GLOBAL_ON,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        -- setpos 1389.400879 666.277100 -127.968750;setang 0.437201 177.274811 0.000000
        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(1389.400879, 666.277100, -191.836243), Angle(0, 0, 0))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(1389.400879, 666.277100, -191.836243),
            Angle(0, 0, 0),
            Vector(-100, -250, 0),
            Vector(100, 250, 200)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- 1577.605347 651.466064 -642.468750
        local checkpoint2 = GAMEMODE:CreateCheckpoint(Vector(1577.605347, 651.466064, -672.468750), Angle(0, 180, 0))
        ents.WaitForEntityByName("introom_elevator_1", function(ent)
            checkpoint2:SetParent(ent)
        end)
        ents.WaitForEntityByName("elevator_trigger_go_up_1", function(ent)
            ent:SetKeyValue("teamwait", "1")
            ent.OnTrigger = function(_, activator)
                GAMEMODE:SetPlayerCheckpoint(checkpoint2, activator)
            end
        end)

        -- 973.017212 -2953.956299 -239.968750
        -- setpos 508.389771 -932.631348 64.031250;setang 0.842813 -0.293497 0.000000
        local checkpoint3 = GAMEMODE:CreateCheckpoint(Vector(508.389771, -932.631348, 0.031250), Angle(0, 45, 0))
        local checkpointTrigger3 = ents.Create("trigger_once")
        checkpointTrigger3:SetupTrigger(
            Vector(481.376953, -937.476746, 0.031250),
            Angle(0, 0, 0),
            Vector(0, -100, 0),
            Vector(10, 100, 100)
        )
        checkpointTrigger3.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint3, activator)
        end

        -- 981.835876 -3084.621826 -239.968750
        local checkpoint4 = GAMEMODE:CreateCheckpoint(Vector(980.400391, -3211.114746,  -239.968750), Angle(0, 90, 0))
        checkpoint4:SetVisiblePos(Vector(973.017212, -2953.956299, -239.968750))
        local checkpointTrigger4 = ents.Create("trigger_once")
        checkpointTrigger4:SetupTrigger(
            Vector(981.835876, -3084.621826, -239.968750),
            Angle(0, 0, 0),
            Vector(-50, -10, 0),
            Vector(50, 10, 100)
        )
        checkpointTrigger4.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint4, activator)
        end

    end
end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
