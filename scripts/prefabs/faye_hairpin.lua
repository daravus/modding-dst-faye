local Assets = {
    Asset( "ANIM", "anim/faye_hairpin.zip"),
    
    Asset( "ATLAS", "images/inventoryimages/faye_hairpin.xml"),
    Asset( "IMAGE", "images/inventoryimages/faye_hairpin.tex"),
}

local function OnEquip(inst, owner)
	-- This will override symbol "swap_body" of the equipping player with your custom build symbol.
	-- Here's what this function is overriding:
	-- owner.AnimState:OverrideSymbol(Player's_symbol, Your_build(*.zip_filename), Symbol_from_your_build(name_of_subfolder_with_art)
    owner.AnimState:OverrideSymbol("swap_hat", "faye_hairpin", "swap_hat")
	
	-- Show/Hide some of the layers of the character while equipping the hat.
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR_HAT")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Hide("HAIR")
	
	-- If the equipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Show("HEAD_HAT")
	end
	
	-- If we should lose usage percent over time while wearing the hat - start dropping the percentage when we're equipping the hat.
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end

local function OnUnequip(inst, owner) 
	-- Clear the hat symbol from wearer's head.
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	
	-- Show/Hide some of the layers of the character while unequipping the hat.
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")

	-- If the unequipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end
	
	-- Stop consuming usage percent if the hat is not equipped.
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function MainFunction()
	-- Functions which are performed both on Client and Server start here.
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

	-- Add minimap icon. Remember about its XML in modmain.lua!
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("faye_hairpin.tex")

	--[[ ANIMSTATE ]]--
	-- This is the name visible on the top of hierarchy in Spriter.
    inst.AnimState:SetBank("faye_hairpin")
	-- This is the name of your compiled*.zip file.
    inst.AnimState:SetBuild("faye_hairpin")
	-- This is the animation name while item is on the ground.
    inst.AnimState:PlayAnimation("anim")

	--[[ TAGS ]]--
    inst:AddTag("faye_hairpin")
	-- Waterproofer (from waterproofer component) - this tag can be removed, but it's here just in case, to make the game run better.
	inst:AddTag("waterproofer")
	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		-- If we're not the host - stop performing further functions.
		-- Only server functions below.
        return inst
    end
	
    inst:AddComponent("inspectable")

	-- Allow "trading" the hat - used for giving the hat to Pigmen.
    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "faye_hairpin"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/faye_hairpin.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("fueled")
	-- This fuel type will allow us to use Sewing Kit to repair our hat.
	inst.components.fueled.fueltype = FUELTYPE.USAGE
	-- Our custom hat should last about 5 days of constant wearing (480 seconds is 1 day in DST).
	inst.components.fueled:InitializeFuelLevel(480*5)
	-- What should happen when we reach 0% usage - remove the item.
	inst.components.fueled:SetDepletedFn(inst.Remove)

	inst:AddComponent("waterproofer")
	-- Our hat shall grant 20% water resistance to the wearer!
    inst.components.waterproofer:SetEffectiveness(0.2)

    MakeHauntableLaunch(inst)

    return inst
end

return  Prefab("common/inventory/faye_hairpin", MainFunction, Assets)



-- local assets=
-- { 
--     Asset("ANIM", "anim/faye_hairpin.zip"),

--     Asset("ATLAS", "images/inventoryimages/faye_hairpin.xml"),
--     Asset("IMAGE", "images/inventoryimages/faye_hairpin.tex"),
-- }

-- local prefabs = 
-- {
-- }

-- local function fn()

--     local function OnEquip(inst, owner) 
--         owner.AnimState:OverrideSymbol("swap_hat", "faye_hairpin_swap", "swap_hat")
--         owner.AnimState:Show("HAT")
--         owner.AnimState:Show("HAT_HAIR")
--         owner.AnimState:Hide("HAIR_NOHAT")
--         owner.AnimState:Hide("HAIR")
--         print('A')
--         if owner:HasTag("player") then
--             print('B')
--             owner.AnimState:Hide("HEAD")
--             owner.AnimState:Show("HEAD_HAIR")
--         end
--     end

--     local function OnUnequip(inst, owner) 
--         owner.AnimState:Hide("HAT")
--         owner.AnimState:Hide("HAT_HAIR")
--         owner.AnimState:Show("HAIR_NOHAT")
--         owner.AnimState:Show("HAIR")

--         if owner:HasTag("player") then
--             owner.AnimState:Show("HEAD")
--             owner.AnimState:Hide("HEAD_HAIR")
--         end
--     end

--     local inst = CreateEntity()
--     local trans = inst.entity:AddTransform()
--     local anim = inst.entity:AddAnimState()
--     MakeInventoryPhysics(inst)
    
--     anim:SetBank("faye_hairpin")
--     anim:SetBuild("faye_hairpin")
--     anim:PlayAnimation("idle")

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.imagename = "faye_hairpin"
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/faye_hairpin.xml"
    
--     inst:AddComponent("equippable")
--     inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
--     inst.components.equippable:SetOnEquip(OnEquip)
--     inst.components.equippable:SetOnUnequip(OnUnequip)

--     return inst
-- end

-- return  Prefab("common/inventory/faye_hairpin", fn, assets, prefabs)