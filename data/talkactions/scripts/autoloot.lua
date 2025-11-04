function onSay(player, words, param)
    if player:getStorageValue(10931) <= 0 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce nao tem acesso a este comando, visite a STORE no site e adquira seu AutoLoot VIP.")
        return false
    end

    local split = param:split(",")
    local action = split[1]

    if action == "add" then
        local rawItem = split[2] and split[2]:gsub("^%s+", ""):gsub("%s+$", "")
        if not rawItem then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Sintaxe incorreta. Use: !autoloot add nome-do-item")
            return false
        end

        local itemType = ItemType(rawItem)
        if not itemType or itemType:getId() == 0 then
            local itemId = tonumber(rawItem)
            itemType = itemId and ItemType(itemId) or nil
            if not itemType or itemType:getId() == 0 then
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Nao ha nenhum item com esse ID ou nome.")
                return false
            end
        end

        local itemName = tonumber(rawItem) and itemType:getName() or rawItem
        local size = 0
        for i = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
            local storage = player:getStorageValue(i)
            if size == AUTO_LOOT_MAX_ITEMS then
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "A lista esta cheia, remova-a da lista para liberar espaco.")
                break
            end

            if storage == itemType:getId() then
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, itemName .." ja esta na lista.")
                break
            end

            if storage <= 0 then
                player:setStorageValue(i, itemType:getId())
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, itemName .." foi adicionado na lista.")
                break
            end

            size = size + 1
        end

    elseif action == "remove" then
        local rawItem = split[2] and split[2]:gsub("^%s+", ""):gsub("%s+$", "")
        if not rawItem then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Sintaxe incorreta. Use: !autoloot remove nome-do-item")
            return false
        end

        local itemType = ItemType(rawItem)
        if not itemType or itemType:getId() == 0 then
            local itemId = tonumber(rawItem)
            itemType = itemId and ItemType(itemId) or nil
            if not itemType or itemType:getId() == 0 then
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Nao ha nenhum item com esse ID ou nome.")
                return false
            end
        end

        local itemName = tonumber(rawItem) and itemType:getName() or rawItem
        for i = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
            if player:getStorageValue(i) == itemType:getId() then
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, itemName .." foi removido da lista.")
                player:setStorageValue(i, 0)
                return false
            end
        end

        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, itemName .." nao foi encontrado na lista.")

    elseif action == "show" then
        local text = "-- Auto Loot List --\n"
        local count = 1
        for i = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
            local storage = player:getStorageValue(i)
            if storage > 0 then
                text = string.format("%s%d. %s\n", text, count, ItemType(storage):getName())
                count = count + 1
            end
        end

        if count == 1 then
            text = "Empty"
        end

        player:showTextDialog(1950, text, false)

    elseif action == "clear" then
        for i = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
            player:setStorageValue(i, 0)
        end
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "A lista de autoloot foi limpa.")

    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Use os comandos: !autoloot {add, remove, show, clear}")
    end

    return false
end
