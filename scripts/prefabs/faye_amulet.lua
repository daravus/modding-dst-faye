local assets =
{
    Asset("ANIM", "anim/faye_amulet.zip"),
	Asset("IMAGE", "images/inventoryimages/faye_amulet.tex"),
	Asset("ATLAS", "images/inventoryimages/faye_amulet.xml"),
}

local function onequip(inst, owner)
end

local function onunequip(inst, owner)
end

local function commonfn(anim, tag, should_sink)
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("faye_amulet")
    inst.AnimState:SetBuild("faye_amulet")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("hide_percentage")
	inst:AddTag("amulet")
    	
    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
		
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/faye_amulet.xml"
       
    -- inst:AddComponent("armor")
    -- inst.components.armor:InitCondition(100, 0.7)
    -- inst.components.armor.indestructible = true

    -- inst:AddComponent("waterproofer")
    -- inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)

	-- inst:AddComponent("useableitem")
	-- inst.components.useableitem:SetOnUseFn(onuse)

	inst:AddComponent("equippable")
    inst.components.equippable.restrictedtag = "faye"
	inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
	inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    
    inst:AddComponent("tradable")

    -- inst:ListenForEvent("horn_model_change",lightlight)
	
	-- MakeHauntableLaunch(inst)
    return inst
end

local function updatelight(inst, phase)
    if phase == "day" then
        inst.Light:Enable(false) 
    else
        inst.Light:Enable(true)
    end
end

local function lightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetRadius(5)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(229 / 255, 117 / 255, 178 / 255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:WatchWorldState("phase", updatelight)

    updatelight(inst, TheWorld.state.phase)

    return inst
end

local function onuse(inst)
end

return Prefab("faye_amulet", fn, assets)
    prefab("faye_amulet_light", lightfx)