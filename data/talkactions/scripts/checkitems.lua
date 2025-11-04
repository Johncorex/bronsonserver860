function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return false
    end

    if param == "" then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage: /checkitems PlayerName")
        return false
    end

    local target = Player(param)
    if not target then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.")
        return false
    end

    local results = {}

    -- Função recursiva para varrer containers
    local function scanContainer(container, list)
        for i = 0, container:getSize()-1 do
            local item = container:getItem(i)
            if item then
                if item:isContainer() then
                    scanContainer(item, list)
                end
                list[#list+1] = item:getName() .. " x" .. item:getCount()
            end
        end
    end

    -- 1. Checa slots equipados
    local equipped = {}
    for slot = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
        local item = target:getSlotItem(slot)
        if item then
            equipped[#equipped+1] = "[Slot "..slot.."] " .. item:getName() .. " x" .. item:getCount()
        end
    end
    if #equipped > 0 then
        results[#results+1] = "--- EQUIPPED ---"
        for _, line in ipairs(equipped) do
            results[#results+1] = line
        end
    end

    -- 2. Checa backpack
    local inventory = {}
    local backpack = target:getSlotItem(CONST_SLOT_BACKPACK)
    if backpack and backpack:isContainer() then
        scanContainer(backpack, inventory)
    end
    if #inventory > 0 then
        results[#results+1] = "--- INVENTORY ---"
        for _, line in ipairs(inventory) do
            results[#results+1] = line
        end
    end

    -- 3. Checa todos os depots
    local depotItems = {}
    for _, town in pairs(Game.getTowns()) do
        local depot = target:getDepotChest(town:getId(), true)
        if depot then
            scanContainer(depot, depotItems)
        end
    end
    if #depotItems > 0 then
        results[#results+1] = "--- DEPOT ---"
        for _, line in ipairs(depotItems) do
            results[#results+1] = line
        end
    end

    -- 4. Resultado final
    if #results == 0 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, param .. " has no items found.")
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Items of "..param..":")
        for _, line in ipairs(results) do
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, line)
        end
    end

    return false
end
