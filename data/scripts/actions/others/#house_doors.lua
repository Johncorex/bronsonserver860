local config = {
    lockedText   = "It is locked.",
    noAccessText = "You are not the owner of this house.",
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- só se for porta
    if not item:isDoor() then
        return false
    end

    local doorHouseId = item:getActionId()
    if doorHouseId <= 0 then
        -- nenhuma house associada: comportamento padrão
        return false
    end

    -- obtém o houseId do player (nil se não for owner de nenhuma casa)
    local playerHouseId = House:getHouseIdByPlayerGuid(player:getGuid())

    if playerHouseId == doorHouseId then
        -- é o dono: chama o open original
        return false  -- devolvendo false, o engine faz o open/close automaticamente
    end

    -- não é dono
    if playerHouseId then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, config.noAccessText)
    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL, config.lockedText)
    end
    return true  -- bloqueia o uso
end
