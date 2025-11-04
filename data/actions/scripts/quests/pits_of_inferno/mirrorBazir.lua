-- Cortina (UID 6632) e Espelho (UID 6633)

local CURTAIN_UID = 6632
local MIRROR_UID  = 6633

local CURTAIN_ID = 6434 -- id da cortina
local MIRROR_ID  = 1847 -- id do espelho

local CURTAIN_POS = Position(1311, 731, 14) -- posição original da cortina
local CURTAIN_SIDE_POS = Position(1311, 732, 14) -- posição para onde a cortina se move

local TELEPORT_TO = Position(1284, 733, 13) -- destino do espelho

-- Usar a cortina: mover pro lado
local function useCurtain(player, item, fromPosition)
    if item:getId() == CURTAIN_ID then
        -- move cortina para o lado se estiver na posição original
        if fromPosition == CURTAIN_POS then
            item:moveTo(CURTAIN_SIDE_POS)
            CURTAIN_SIDE_POS:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        end
    end
end

-- Usar o espelho: teleportar player e voltar a cortina
local function useMirror(player, item, fromPosition)
    if item:getId() == MIRROR_ID then
        player:teleportTo(TELEPORT_TO)
        TELEPORT_TO:sendMagicEffect(CONST_ME_TELEPORT)

        -- volta a cortina para cobrir o espelho
        local curtain = Tile(CURTAIN_SIDE_POS):getItemById(CURTAIN_ID)
        if curtain then
            curtain:moveTo(CURTAIN_POS)
            CURTAIN_POS:sendMagicEffect(CONST_ME_POFF)
        end
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.uid == CURTAIN_UID then
        useCurtain(player, item, fromPosition)
        return true
    end

    if item.uid == MIRROR_UID then
        useMirror(player, item, fromPosition)
        return true
    end

    return false
end
