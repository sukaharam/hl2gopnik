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

MAPSCRIPT.ImportantPlayerNPCNames =
{
    ["vort_Lab"] = true,
}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        ents.WaitForEntityByName("filter_eli", function(ent)
            ent:Remove()
        end)

        ents.WaitForEntityByName("eli", function(ent)
            ent:SetHealth(100)
        end)

        ents.WaitForEntityByName("mossman", function(ent)
            ent:SetHealth(100)
        end)

        -- Checkpoint
        local checkpoint = GAMEMODE:CreateCheckpoint(Vector(-66.911217, 2753.892822, -1279.968750), Angle(0, 0, 0))
        GAMEMODE:SetPlayerCheckpoint(checkpoint, activator)
        end)

        -- What is it with NPCs being busy?
        ents.WaitForEntityByName("lcs_alyxtour01", function(ent)
            ent:SetKeyValue("busyactor", "0")
        end)

    end

end

function MAPSCRIPT:PostPlayerSpawn(ply)

    --DbgPrint("PostPlayerSpawn")

end

return MAPSCRIPT
