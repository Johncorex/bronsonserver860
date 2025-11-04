-- data/lib/core/container.lua
function Container.isContainer(self)
    return true
end

function Container.createLootItem(self, item)
    if not item or type(item) ~= "table" then
        return true
    end

    -- capacidade do corpse (compat com bases sem getEmptySlots)
    local function hasFree(container)
        if container.getEmptySlots then
            return container:getEmptySlots() > 0
        end
        if container.getCapacity and container.getSize then
            return (container:getCapacity() - container:getSize()) > 0
        end
        return true
    end
    if not hasFree(self) then
        return true
    end

    -- campos compatíveis entre bases
    local idOrName = item.itemId or item.id or item.name
    local itType   = ItemType(idOrName)
    local itId     = itType and itType:getId() or 0
    if itId == 0 then
        print(("[DropLoot] invalid item in loot: %s"):format(tostring(idOrName)))
        return true
    end

    local maxCount = item.countmax or item.maxCount or 1
    local rand     = getLootRandom()

    local count = 0
    if rand < item.chance then
        if itType:isStackable() then
            count = (rand % maxCount) + 1
        else
            count = 1
        end
    end
    if count <= 0 then
        return true
    end

    -- criar corretamente (fluids/splash/runa com charges)
    local tmpItem
    local wantSubType = item.subType and item.subType ~= -1 and item.subType or nil
    local function hasMethod(obj, name)
    return obj and type(obj[name]) == "function"
	end

	local isFluidContainer = hasMethod(itType, "isFluidContainer") and itType:isFluidContainer() or false
	local isSplash         = hasMethod(itType, "isSplash")         and itType:isSplash()         or false
	-- alguns TFS expõem o "group": 2 = fluid container, 3 = splash
	local itGroup          = hasMethod(itType, "getGroup") and itType:getGroup() or -1
	local isFluidLike      = isFluidContainer or isSplash or (itGroup == 2 or itGroup == 3)

	if isFluidLike then
		-- fluidos/splash precisam nascer com subType correto
		local subType = (item.subType and item.subType ~= -1) and item.subType or 0
		local created = Game.createItem(itId, subType)
		if not created then
			print(("[DropLoot] createItem failed: id=%d (fluid), subType=%d"):format(itId, subType))
			return false
		end
		local ret = self:addItemEx(created)
		if ret ~= RETURNVALUE_NOERROR then
			print(("[DropLoot] addItemEx failed: id=%d (fluid), ret=%d"):format(itId, ret))
			return false
		end
		tmpItem = created
	else
		tmpItem = self:addItem(itId, math.min(count, 100))
		if not tmpItem then
			print(("[DropLoot] addItem failed: id=%d name=%s count=%d slots=%s"):
				format(itId, itType:getName(), count, self.getEmptySlots and self:getEmptySlots() or "?"))
			return false
		end
		-- se tiver charges/subType (ex.: runa/charge tool), aplicar agora
		if item.subType and item.subType ~= -1 then
			tmpItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, item.subType)
		end
	end

    -- filhos (loot dentro de containers)
    if tmpItem:isContainer() and item.childLoot and #item.childLoot > 0 then
        for i = 1, #item.childLoot do
            if not tmpItem:createLootItem(item.childLoot[i]) then
                tmpItem:remove()
                return false
            end
        end
    end

    -- atributos "soltos" usados por TFS
    if item.actionId and item.actionId ~= -1 then
        tmpItem:setActionId(item.actionId)
    end
    if item.text and item.text ~= "" then
        tmpItem:setText(item.text)
    end

    -- lista generica de atributos <attribute key="" value="">
    if item.attributes and type(item.attributes) == "table" then
        for _, attr in ipairs(item.attributes) do
            local k, v = tostring(attr.key or ""), attr.value
            if k == "aid" or k == "actionId" or k == "actionid" then
                tmpItem:setActionId(tonumber(v) or 0)
            elseif k == "text" then
                tmpItem:setText(tostring(v))
            elseif k == "description" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, tostring(v))
            elseif k == "article" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_ARTICLE, tostring(v))
            elseif k == "charges" or k == "subType" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, tonumber(v) or 0)
            elseif k == "duration" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_DURATION, tonumber(v) or 0)
            elseif k == "attack" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_ATTACK, tonumber(v) or 0)
            elseif k == "defense" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_DEFENSE, tonumber(v) or 0)
            elseif k == "extradefense" or k == "extraDefense" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE, tonumber(v) or 0)
            elseif k == "armor" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_ARMOR, tonumber(v) or 0)
            elseif k == "hitchance" or k == "hitChance" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_HITCHANCE, tonumber(v) or 0)
            elseif k == "shootrange" or k == "shootRange" then
                tmpItem:setAttribute(ITEM_ATTRIBUTE_SHOOTRANGE, tonumber(v) or 0)
            -- outros keys podem ser adicionados aqui se você usar mais attrs no XML
            end
        end
    end

    return true
end
