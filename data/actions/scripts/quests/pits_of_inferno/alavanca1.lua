local bridgePosition = Position(1373, 675, 11)

local function revertBridge()
    local bridge = Tile(bridgePosition):getItemById(5770)
    if bridge then
        bridge:transform(493) -- volta a ser água
    end
end

local function revertLever(position)
    local leverItem = Tile(position):getItemById(1946)
    if leverItem then
        leverItem:transform(1945)
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid ~= 1945 then
        return false
    end

    local water = Tile(bridgePosition):getItemById(493)
    if water then
        water:transform(5770) -- cria a ponte
        bridgePosition:sendMagicEffect(CONST_ME_WATERSPLASH) -- efeito de splash
        addEvent(revertBridge, 10 * 60 * 1000) -- depois de 10 min volta pra água
    end

    item:transform(1946)
    addEvent(revertLever, 10 * 60 * 1000, toPosition)
    return true
end
