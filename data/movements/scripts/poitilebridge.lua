-- Teleports de ActionID do labirinto

local DESTINATIONS = {
    [25686] = Position(1414, 614, 10),

}

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then return true end

    local dest = DESTINATIONS[item.actionid]
    if dest then
        player:teleportTo(dest)
    end
    return true
end
