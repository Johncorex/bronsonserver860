function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    local pos = player:getPosition()

    if item.itemid == 8187 then
        if player:getStamina() < 2401 then
            player:setStamina(2520)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Sua stamina foi restaurada.")
            pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
            item:remove(1)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce ainda tem stamina verde!")
            pos:sendMagicEffect(CONST_ME_POFF)
        end
    end
    return true
end
