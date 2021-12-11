PrefabFiles = {
	"faye",
	"faye_none",
	-- "faye_hairpin",
}

Assets = {
    -- Asset( "ANIM",  "anim/faye_.zip"),

    Asset( "IMAGE", "images/saveslot_portraits/faye.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/faye.xml" ),

    Asset( "IMAGE", "bigportraits/faye.tex" ),
    Asset( "ATLAS", "bigportraits/faye.xml" ),

	Asset( "IMAGE", "images/map_icons/faye.tex" ),
	Asset( "ATLAS", "images/map_icons/faye.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_faye.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_faye.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_faye.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_faye.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_faye.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_faye.xml" ),

	Asset( "IMAGE", "images/names_faye.tex" ),
    Asset( "ATLAS", "images/names_faye.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/faye.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/faye.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/faye_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/faye_silho.xml" ),

    Asset( "SOUNDPACKAGE", "sound/faye.fev" ),
    Asset( "SOUND", "sound/faye.fsb" ),

}

RemapSoundEvent( "dontstarve/characters/faye", "faye/faye" )
RemapSoundEvent( "dontstarve/characters/faye/talk_LP", "faye/faye/talk_LP" )
RemapSoundEvent( "dontstarve/characters/faye/ghost_LP", "faye/faye/ghost_LP" )
RemapSoundEvent( "dontstarve/characters/faye/hurt", "faye/faye/hurt" )
RemapSoundEvent( "dontstarve/characters/faye/death_voice", "faye/faye/death_voice" )
RemapSoundEvent( "dontstarve/characters/faye/emote", "faye/faye/emote" )
RemapSoundEvent( "dontstarve/characters/faye/pose", "faye/faye/pose" )
RemapSoundEvent( "dontstarve/characters/faye/yawn", "faye/faye/yawn" )

AddMinimapAtlas("images/map_icons/faye.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.faye = "The Modern Witch"
STRINGS.CHARACTER_NAMES.faye = "Faye"
STRINGS.CHARACTER_DESCRIPTIONS.faye = "*Is a rune charmer\n*Can befriend bats\n*Asian cuisine expert"
STRINGS.CHARACTER_QUOTES.faye = "\"Quote\""
STRINGS.CHARACTER_SURVIVABILITY.faye = "Very probable"

-- Custom speech strings
STRINGS.CHARACTERS.FAYE = require "speech_faye"

-- The character's name as appears in-game 
STRINGS.NAMES.FAYE = "Faye"
STRINGS.SKIN_NAMES.faye_none = "Faye"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("faye", "FEMALE", skin_modes)

-- Add charcoal drop on cooking
-- AddComponentPostInit("stewer", function(self)
-- 	local oldStartCooking = self.StartCooking
-- 	function self:StartCooking(doer)
-- 		oldStartCooking(self,doer)
-- 		local Destroy = false
-- 		if doer and doer.prefab == "faye" then
-- 			if self.inst:IsValid() and math.random() < 0.15 and self.product_spoilage ~= nil  then 
-- 				self.product_spoilage = self.product_spoilage - 0.15
-- 				FlingItem(SpawnPrefab("charcoal"), self.inst)
-- 			end
-- 		end
-- 	end
-- end)



-- AddSimPostInit( function()
-- 	local player_pos = GLOBAL.GetPlayer():GetPosition()
-- 	local hat = GLOBAL.SpawnPrefab('faye_hairpin')
-- 	hat.Transform:SetPosition(player_pos.x, player_pos.y, player_pos.z)
-- end)