function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    -- Checa se os dois estão na mesma party
    local creatureParty = creature:getParty()
    local attackerParty = attacker:getParty()

    if creatureParty and attackerParty and creatureParty == attackerParty then
        attacker:sendCancelMessage("You cannot attack a member of your party.")
        return 0, primaryType, 0, secondaryType
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
