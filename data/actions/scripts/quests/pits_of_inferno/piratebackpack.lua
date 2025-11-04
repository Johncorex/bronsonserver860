-- Quest Skeleton (UID 6629) dá itens 6561 e 5926
-- Usa o próprio UID como storage para marcar que já foi coletado.

local REWARD_UID = 6629
local REWARDS = {
    {id = 6561, count = 1},
    {id = 5926, count = 1}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.uid ~= REWARD_UID then
        return false
    end

    -- storage = UID
    local storage = REWARD_UID
    if player:getStorageValue(storage) > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The skeleton is empty.")
        return true
    end

    -- dá os itens
    for _, reward in ipairs(REWARDS) do
        player:addItem(reward.id, reward.count)
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found some items.")
    player:setStorageValue(storage, 1)
    return true
end
