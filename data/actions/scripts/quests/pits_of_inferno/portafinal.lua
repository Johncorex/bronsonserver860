-- Porta que só abre se o player tiver todos os tronos (25690–25696)
local THRONES = {25690, 25691, 25692, 25693, 25694, 25695, 25696}

-- mapeamento das portas permitidas
local DOORS = {
    [5132] = 5133,
    [5133] = 5132,
    [5123] = 5124,
    [5124] = 5123,
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- verifica se a porta é uma das configuradas
    local newId = DOORS[item.itemid]
    if not newId then
        player:sendCancelMessage("Esta porta nao pode ser usada neste script.")
        return true
    end

    -- verifica se tem todos os tronos
    for _, storage in ipairs(THRONES) do
        if player:getStorageValue(storage) ~= 1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A porta esta selada contra intrusos.")
            return true
        end
    end

    -- abre/fecha a porta
    item:transform(newId)

    -- puxa o player para dentro da porta (posição da porta)
    player:teleportTo(toPosition)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end
