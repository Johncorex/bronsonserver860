local AID        = 25663
local LADDER_POS = Position(1426, 658, 11)
local LADDER_ID  = 5543

local function ensureLadder()
    local t = Tile(LADDER_POS)
    if t and not t:getItemById(LADDER_ID) then
        Game.createItem(LADDER_ID, 1, LADDER_POS)
        LADDER_POS:sendMagicEffect(CONST_ME_MAGIC_BLUE) -- efeito ao criar
    end
end

local function removeLadder()
    local t = Tile(LADDER_POS)
    if not t then return end
    while true do
        local it = t:getItemById(LADDER_ID)
        if not it then break end
        it:remove()
    end
    LADDER_POS:sendMagicEffect(CONST_ME_POFF) -- efeito ao sumir
end

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then return true end

    if item.actionid ~= AID then return true end

    position:sendMagicEffect(CONST_ME_MAGIC_BLUE) -- efeito ao pisar
    ensureLadder()
    return true
end

function onStepOut(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then return true end

    if item.actionid ~= AID then return true end

    removeLadder()
    return true
end
