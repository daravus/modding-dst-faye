local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

-- Your character's stats
TUNING.FAYE_HEALTH = 200
TUNING.FAYE_HUNGER = 200
TUNING.FAYE_SANITY = 200

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.FAYE = {
	"flint",
	"flint",
	"twigs",
	"twigs",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.FAYE
end
local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)

	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 10
	
	local light = inst.entity:AddLight()
	inst.Light:Enable(true)
	inst.Light:SetRadius(5)
	inst.Light:SetFalloff(1)
	inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255, 195/255, 150/255)

	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "faye_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "faye_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


local function updatelight(inst, phase)
    if phase == "day" then
        inst.Light:Enable(false) 
    else
        inst.Light:Enable(true)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst)

	inst:WatchWorldState("phase", updatelight)

    updatelight(inst, TheWorld.state.phase)
	
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "faye.tex" )
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	inst.soundsname = "Willow"
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.FAYE_HEALTH)
	inst.components.hunger:SetMax(TUNING.FAYE_HUNGER)
	inst.components.sanity:SetMax(TUNING.FAYE_SANITY)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1

	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 10
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("faye", prefabs, assets, common_postinit, master_postinit, prefabs)
