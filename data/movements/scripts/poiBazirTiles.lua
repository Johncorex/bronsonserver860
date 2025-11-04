-- Teleports de ActionID do labirinto

local DESTINATIONS = {
    [25697] = Position(1326, 704, 15),
	[25698] = Position(1322, 733, 14),
	[25699] = Position(1390, 683, 13),
	
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

