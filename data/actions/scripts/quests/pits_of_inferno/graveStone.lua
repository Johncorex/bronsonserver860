function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- item com actionid 6601
    local dest = Position(1363, 672, 10)
    player:teleportTo(dest)
    dest:sendMagicEffect(CONST_ME_TELEPORT) -- opcional
    player:say('Muahahahaha..', TALKTYPE_MONSTER_SAY, false, player)
    return true
end