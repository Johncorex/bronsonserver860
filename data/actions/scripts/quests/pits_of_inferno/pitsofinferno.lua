-- data/actions/scripts/quests/bronson_quest.lua
local choiceChests = {
    [6645] = {itemId = 8922, itemName = "Morguls Effigy"},
    [6646] = {itemId = 8856, itemName = "Churchill's Bow"},
    [6647] = {itemId = 8852, itemName = "Buriza"},
    [6648] = {itemId = 7405, itemName = "Dagorleaf"},
    [6649] = {itemId = 7435, itemName = "Stonegrinder"},
    [6650] = {itemId = 7431, itemName = "Olog-hai Breaker"},
}

local rewardChests = {
    [6651] = {itemId = 6132, count = 1},   -- Soft boots
    [6652] = {itemId = 5791, count = 1},   -- Stuffed Dragon
    [6653] = {itemId = 2361, count = 1},   -- Frozen Starlight
    [6654] = {itemId = 2160, count = 10},  -- 10x Crystal Coin
    [6655] = {itemId = 2365, count = 1},   -- Backpack of Holding
}

-- Storage para controle
local STORAGE = {
    choice = 6645,   -- Se já escolheu um dos 6
    reward = 6646    -- Base para rewards fixos
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local uid = item.uid

    -- -----------------------------
    -- GRUPO DE ESCOLHA (1 de 6)
    -- -----------------------------
    if choiceChests[uid] then
        if player:getStorageValue(STORAGE.choice) > 0 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja escolheu a sua recompensa.")
            return true
        end

        local reward = choiceChests[uid]
        player:addItem(reward.itemId, 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce escolheu " .. reward.itemName .. " como sua recompensa.")
        player:setStorageValue(STORAGE.choice, 1)
        return true
    end

    -- -----------------------------
    -- RECOMPENSAS FIXAS
    -- -----------------------------
    if rewardChests[uid] then
        local index = STORAGE.reward + uid
        if player:getStorageValue(index) > 0 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Esse bau esta vazio")
            return true
        end

        local reward = rewardChests[uid]
        player:addItem(reward.itemId, reward.count)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce coletou sua recompensa.")
        player:setStorageValue(index, 1)
        return true
    end

    return false
end
