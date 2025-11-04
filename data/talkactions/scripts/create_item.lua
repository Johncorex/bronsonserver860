local invalidIds = {
    [1] = true, [2] = true, [3] = true, [4] = true, [5] = true,
    [6] = true, [7] = true, [10] = true, [11] = true, [13] = true,
    [14] = true, [15] = true, [19] = true, [21] = true, [26] = true,
    [27] = true, [28] = true, [35] = true, [43] = true
}

-- Função auxiliar para split (caso não exista)
local function splitString(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function onSay(player, words, param)
    -- Verificação de grupo GOD (groupId 6)
    if player:getGroup():getId() < 6 then
        player:sendCancelMessage("You need GOD access to use this command.")
        return false
    end
    
    if param == "" then
        player:sendCancelMessage("Command param required. Usage: /i <itemid[,count]>")
        return false
    end
    
    -- Split usando função auxiliar
    local split = splitString(param, ",")
    if not split or not split[1] then
        player:sendCancelMessage("Invalid parameters. Usage: /i <itemid[,count]>")
        return false
    end
    
    local itemId = tonumber(split[1])
    local itemType = ItemType(itemId or split[1])
    
    -- Verificação mais robusta do ItemType
    if not itemType or itemType:getId() == 0 then
        player:sendCancelMessage("There is no item with that id or name.")
        return false
    end
    
    if invalidIds[itemType:getId()] then
        player:sendCancelMessage("You cannot create this item.")
        return false
    end
    
    local count = 1
    if split[2] then
        count = tonumber(split[2]) or 1
    end
    
    -- Adjust count based on item type
    if itemType:isStackable() then
        count = math.min(10000, math.max(1, count))
    elseif itemType:isFluidContainer() then
        count = math.max(0, count)
    elseif not itemType:isKey() then
        count = math.min(100, math.max(1, count))
    end
    
    -- Handle key actionId
    local actionId = 0
    if itemType:isKey() then
        actionId = count
        count = 1
    end
    
    -- Create the item(s)
    local result = player:addItem(itemType:getId(), count)
    if not result then
        player:sendCancelMessage("Failed to create item.")
        return false
    end
    
    -- Post-creation handling
    if itemType:isKey() then
        if type(result) == "table" then
            for _, item in pairs(result) do
                item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, actionId)
                item:decay()
            end
        else
            result:setAttribute(ITEM_ATTRIBUTE_ACTIONID, actionId)
            result:decay()
        end
    elseif not itemType:isStackable() then
        if type(result) == "table" then
            for _, item in pairs(result) do
                item:decay()
            end
        else
            result:decay()
        end
    end
    
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Item created successfully!")
    return false
end