-- Teleports de ActionID do labirinto

local DESTINATIONS = {
    [25664] = Position(1399, 653, 9),
    [25665] = Position(1413, 662, 9),
    [25666] = Position(1433, 640, 9),
    [25667] = Position(1419, 626, 9),
    [25668] = Position(1408, 627, 9),
    [25669] = Position(1427, 635, 9),
    [25670] = Position(1412, 656, 9),
    [25671] = Position(1399, 647, 9),
    [25672] = Position(1426, 662, 9),
    [25673] = Position(1430, 636, 9),
    [25674] = Position(1428, 628, 9),

    -- todos os resets para o inicio
    [25675] = Position(1426, 657, 9),
    [25676] = Position(1426, 657, 9),
    [25677] = Position(1426, 657, 9),
    [25678] = Position(1426, 657, 9),
    [25679] = Position(1426, 657, 9),
    [25680] = Position(1426, 657, 9),
    [25681] = Position(1426, 657, 9),
    [25682] = Position(1426, 657, 9),
    [25683] = Position(1426, 657, 9),
    [25684] = Position(1426, 657, 9),
    [25685] = Position(1426, 657, 9),
}

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then return true end

    local dest = DESTINATIONS[item.actionid]
    if dest then
        player:teleportTo(dest)
        dest:sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end
