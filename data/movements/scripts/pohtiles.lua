function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local destinations = {
        [25661] = Position(1363, 666, 10),
        [25662] = Position(1363, 671, 10)
    }

    local dest = destinations[item.actionid]
    if dest then
        player:teleportTo(dest)
        dest:sendMagicEffect(CONST_ME_TELEPORT)
    end

    return true
end
