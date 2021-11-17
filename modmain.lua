PrefabFiles = {
	"faye",
	"faye_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/faye.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/faye.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/faye.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/faye.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/faye_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/faye_silho.xml" ),

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
	
	Asset( "IMAGE", "images/names_gold_faye.tex" ),
    Asset( "ATLAS", "images/names_gold_faye.xml" ),
}

AddMinimapAtlas("images/map_icons/faye.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.faye = "The Sample Character"
STRINGS.CHARACTER_NAMES.faye = "Esc"
STRINGS.CHARACTER_DESCRIPTIONS.faye = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.faye = "\"Quote\""
STRINGS.CHARACTER_SURVIVABILITY.faye = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.FAYE = require "speech_faye"

-- The character's name as appears in-game 
STRINGS.NAMES.FAYE = "Esc"
STRINGS.SKIN_NAMES.faye_none = "Esc"

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
