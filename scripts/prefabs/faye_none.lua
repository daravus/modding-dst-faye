local assets =
{
	Asset( "ANIM", "anim/faye.zip" ),
	Asset( "ANIM", "anim/ghost_faye_build.zip" ),
}

local skins =
{
	normal_skin = "faye",
	ghost_skin = "ghost_faye_build",
}

return CreatePrefabSkin("faye_none",
{
	base_prefab = "faye",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"FAYE", "CHARACTER", "BASE"},
	build_name_override = "faye",
	rarity = "Character",
})