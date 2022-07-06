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
    ["player_items_template"] = true,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        local boxcar_human
        local boxcar_vort
        ents.WaitForEntityByName("boxcar_human", function(ent)
            ent.ImportantNPC = true
            boxcar_human = ent
        end)

        ents.WaitForEntityByName("boxcar_vort", function(ent)
            ent.ImportantNPC = false
            boxcar_vort = ent
        end)

        GAMEMODE:WaitForInput("boxcar_human", "StopScripting", function(ent)
            DbgPrint("NPCs no longer important")
            if IsValid(boxcar_vort) then
                boxcar_vort.ImportantNPC = false
            end
            if IsValid(boxcar_human) then
                boxcar_human.ImportantNPC = false
            end
        end)

        local checkpoint1 = GAMEMODE:CreateCheckpoint(Vector(650.433105, -6424.663086, 540.031250))
        checkpoint1:SetVisiblePos(Vector(619.656433, -6512.142578, 540.031250))
        local checkpointTrigger1 = ents.Create("trigger_once")
        checkpointTrigger1:SetupTrigger(
            Vector(614.625732, -6519.078613, 540.031250),
            Angle(0,0,0),
            Vector(-100, -100, 0),
            Vector(100, 100, 180)
        )
        checkpointTrigger1.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint1, activator)
        end

        -- 447.302185 -2656.709961 576.031250
        local checkpoint3 = GAMEMODE:CreateCheckpoint(Vector(447.302185, -2656.709961, 576.031250), Angle(0, 180, 0))
        local checkpointTrigger3 = ents.Create("trigger_once")
        checkpointTrigger3:SetupTrigger(
            Vector(447.302185, -2656.709961, 576.031250),
            Angle(0,0,0),
            Vector(-50, -50, 0),
            Vector(50, 50, 180)
        )
        checkpointTrigger3.OnTrigger = function(_, activator)
            GAMEMODE:SetPlayerCheckpoint(checkpoint3, activator)
        end

        -- 544.810791 -3423.548584 322.719330
        local checkpoint4 = GAMEMODE:CreateCheckpoint(Vector(473.498352, -3530.257324, 256.031250), Angle(0, 90, 0))
        local checkpointTrigger4 = ents.Create("trigger_once")
        checkpointTrigger4:SetupTrigger(
            Vector(544.810791, -3423.548584, 322.719330),
            Angle(0,0,0),
            Vector(-70, -70, -50),
            Vector(70, 70, 100)
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
