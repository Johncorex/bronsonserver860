-- Alavanca UID 6624: puxa (1945->1946), remove pedra 387 em {1432,652,11},
-- após 30 min volta a alavanca (1946->1945) e recria a pedra.

local STONE_POS = Position(1432, 652, 11)
local STONE_ID  = 387
local RESET_MS  = 30 * 60 * 1000 -- 30 minutos

local function resetLeverAndStone(leverPos)
    -- Volta a alavanca para 1945
    local lever = Tile(leverPos):getItemById(1946)
    if lever then
        lever:transform(1945)
    end

    -- Recria a pedra se não existir
    if not Tile(STONE_POS):getItemById(STONE_ID) then
        Game.createItem(STONE_ID, 1, STONE_POS)
        -- (efeito ao reaparecer é opcional; se quiser, descomente a linha abaixo)
        -- STONE_POS:sendMagicEffect(CONST_ME_BLOCKHIT)
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Garante que é a alavanca certa e na posição inicial
    if item.uid ~= 6624 or item.itemid ~= 1945 then
        return false
    end

    -- Remove a pedra 387 no local
    local stone = Tile(STONE_POS):getItemById(STONE_ID)
    if stone then
        stone:remove()
        STONE_POS:sendMagicEffect(CONST_ME_EXPLOSIONAREA) -- efeito na pedra sumindo
    end

    -- Puxa a alavanca e efeito nela
    item:transform(1946)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE) -- efeito na alavanca

    -- Agenda o reset em 30 minutos
    addEvent(resetLeverAndStone, RESET_MS, toPosition)
    return true
end
