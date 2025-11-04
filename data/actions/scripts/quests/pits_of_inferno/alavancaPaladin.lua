-- config
local FIRE_POS = Position(1407, 672, 11)
local FIRE_ID = 6289
local LEVER_RESET_TIME = 30 * 60 * 1000 -- 30 minutos

-- voc IDs permitidos
local allowedVocations = {
    [3] = true, [7] = true, [11] = true, [15] = true, -- Paladin
    [21] = true, [22] = true, [23] = true, [24] = true -- Elf
}

-- função para resetar alavanca e fogo
local function resetLeverAndFire(leverPos)
    local lever = Tile(leverPos):getItemById(1946)
    if lever then
        lever:transform(1945) -- volta a alavanca
    end

    -- recoloca o fogo
    if not Tile(FIRE_POS):getItemById(FIRE_ID) then
        Game.createItem(FIRE_ID, 1, FIRE_POS)
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- só UID 6604
    if item.uid ~= 6606 then
        return false
    end

    -- checa voc ID
    local vocId = player:getVocation():getId()
    if not allowedVocations[vocId] then
        player:sendCancelMessage("Sua vocacao nao consegue puxar essa alavanca.")
        return true
    end

    -- só se estiver em posição 1945 (não puxada)
    if item.itemid ~= 1945 then
        return false
    end

    -- remove o fogo
    local fire = Tile(FIRE_POS):getItemById(FIRE_ID)
    if fire then
        fire:remove()
        FIRE_POS:sendMagicEffect(CONST_ME_FIREAREA) -- efeito quando o fogo some
    end

    -- puxa a alavanca
    item:transform(1946)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE) -- efeito ao usar alavanca

    -- agenda reset em 30 minutos
    addEvent(resetLeverAndFire, LEVER_RESET_TIME, toPosition)

    return true
end
