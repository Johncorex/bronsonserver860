-- Duas alavancas encadeadas: 6630 (primeira) e 6631 (segunda)
-- A segunda só funciona se a primeira já estiver puxada (id 1946).
-- Teleport criado permanece até o servidor reiniciar.

local FIRST_UID  = 6630
local SECOND_UID = 6631
local FIRST_POS  = Position(1393, 680, 13) -- posição da primeira alavanca
local SECOND_POS = nil -- se quiser pode por a posição exata da segunda, opcional

local TELEPORT_POS = Position(1388, 684, 13)
local TELEPORT_TO  = Position(1338, 704, 15)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Primeira alavanca
    if item.uid == FIRST_UID and item.itemid == 1945 then
        item:transform(1946)
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        return true
    end

    -- Segunda alavanca
    if item.uid == SECOND_UID and item.itemid == 1945 then
        local lever1 = Tile(FIRST_POS):getItemById(1946)
        if not lever1 then
            player:sendCancelMessage("Algo esta errado...")
            return true
        end

        if not Tile(TELEPORT_POS):getItemById(1387) then
            local tp = Game.createItem(1387, 1, TELEPORT_POS)
            if tp then
                tp:setDestination(TELEPORT_TO)
            end
        end

        item:transform(1946)
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        return true
    end

    return false
end
