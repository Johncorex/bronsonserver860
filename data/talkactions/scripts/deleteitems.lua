function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return false
    end

    if param == "" then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage: /deleteitem PlayerName, ItemName")
        return false
    end

    local parts = param:split(",")
    if #parts < 2 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage: /deleteitem PlayerName, ItemName")
        return false
    end

    local targetName = parts[1]:trim()
    local itemName = parts[2]:trim():lower()

    local target = Player(targetName)
    if not target then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.")
        return false
    end

    -- função recursiva para procurar e remover item em containers
    local function findAndRemove(container)
        for i = 0, container:getSize()-1 do
            local item = container:getItem(i)
            if item then
                if item:getName():lower() == itemName then
                    item:remove()
                    return true
                end
                if item:isContainer() and findAndRemove(item) then
                    return true
                end
            end
        end
        return false
    end

    -- 1. Checa slots equipados
    for slot = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
        local item = target:getSlotItem(slot)
        if item and item:getName():lower() == itemName then
            item:remove()
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Removed "..itemName.." from "..targetName..".")
            return false
        end
    end

    -- 2. Checa backpack
    local backpack = target:getSlotItem(CONST_SLOT_BACKPACK)
    if backpack and backpack:isContainer() and findAndRemove(backpack) then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Removed "..itemName.." from "..targetName..".")
        return false
    end

    -- 3. Checa depots
    for _, town in pairs(Game.getTowns()) do
        local depot = target:getDepotChest(town:getId(), true)
        if depot and findAndRemove(depot) then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Removed "..itemName.." from "..targetName..".")
            return false
        end
    end

    -- Se não achou
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, targetName.." does not have item: "..itemName)
    return false
end
