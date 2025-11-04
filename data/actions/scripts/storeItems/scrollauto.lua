function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == 9004 then
        if player:getStorageValue(10931) <= 0 then
            player:setStorageValue(10931, 1)
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce recebeu o AutoLoot VIP!")
			item:remove()
        else
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce ja tem o AutoLoot VIP!")
        end
    end
    return true
end