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

MAPSCRIPT.EntityFilterByName =
{
    ["player_items_template"] = true,
}

MAPSCRIPT.InputFilters =
{
}

MAPSCRIPT.GlobalStates =
{

}

function MAPSCRIPT:Init()
end

function MAPSCRIPT:PostInit()

    if SERVER then

        local cupcop_can = nil
        local cupcop = nil
        local cupcopSpeech =
        {
            "npc/combine_soldier/vo/sectorisnotsecure.wav",
            "npc/combine_soldier/vo/reaper.wav",
            "npc/combine_soldier/vo/stayalert.wav",
            "npc/combine_soldier/vo/ghost.wav",
            "npc/combine_soldier/vo/target.wav",
            "npc/combine_soldier/vo/visualonexogens.wav",
        }

        ents.WaitForEntityByName("cupcop_can", function(ent)
            cupcop_can = ent
        end)

        ents.WaitForEntityByName("cupcop", function(ent)
            cupcop = ent
        end)


        -- Why not..
        hook.Add("VehicleMove", "Lambda_SwingSeat", function(ply, vehicle, cmd)

            if vehicle ~= seat_1 and vehicle ~= seat_2 then
                return
            end

            local parent = vehicle:GetParent()
            local phys = parent:GetPhysicsObject()
            if IsValid(phys) then

                if cmd:KeyDown(IN_FORWARD) then
                    local fwd = vehicle:GetForward()
                    phys:ApplyForceCenter(fwd * 30)
                elseif cmd:KeyDown(IN_BACK) then
                    local fwd = vehicle:GetForward()
                    phys:ApplyForceCenter(-fwd * 30)
                end

            end

        end)

    end

end

return MAPSCRIPT
