local newStonePos = Position(1381, 673, 11)
local LAVA_ID   = 598
local NEW_ID    = 5815

local lavaAreas = {
    {fromx = 1379, tox = 1383, fromy = 673, toy = 677, z = 11},
    {fromx = 1381, tox = 1382, fromy = 678, toy = 678, z = 11},
    {fromx = 1377, tox = 1378, fromy = 676, toy = 678, z = 11},
    {fromx = 1381, tox = 1384, fromy = 672, toy = 672, z = 11},
    {fromx = 1384, tox = 1384, fromy = 673, toy = 674, z = 11},
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.actionid ~= 6603 then
        return false
    end

    local oldPos = item:getPosition()

    -- move a pedra
    item:moveTo(newStonePos)
    newStonePos:sendMagicEffect(CONST_ME_GROUNDSHAKER)

    -- efeito watersplash na posição antiga por 3 segundos
    oldPos:sendMagicEffect(CONST_ME_WATERSPLASH)
    for i = 1, 3 do
        addEvent(function(pos)
            pos:sendMagicEffect(CONST_ME_WATERSPLASH)
        end, i * 1000, oldPos)
    end

    -- transforma as lavas
    for _, area in ipairs(lavaAreas) do
        for x = area.fromx, area.tox do
            for y = area.fromy, area.toy do
                local pos = Position(x, y, area.z)
                local ground = Tile(pos):getGround()
                if ground and ground:getId() == LAVA_ID then
                    ground:transform(NEW_ID)
                    pos:sendMagicEffect(CONST_ME_FIREAREA)
                end
            end
        end
    end

    return true
end
