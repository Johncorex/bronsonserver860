local area = createCombatArea({
    {0, 0, 1, 0, 0},
    {0, 1, 1, 1, 0},
    {1, 1, 3, 1, 1},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0}
})

-- Configurações de crítico
local CRIT_CONFIG = {
    multiplier = 2.0,
    message = "CRITICAL!"
}

-- Armas com crítico (ID: chance%)
local CRIT_WEAPONS = {
    [7438] = 4,   -- ELVEN BOW
    [8854] = 6,   -- WARSINGER BOW
    [8856] = 4,   -- CHURCHILLS BOW
    [8855] = 7,   -- Eaglehorn
    [8858] = 9    -- Elethriel's Elemental Bow
}

-- Cria o combate normal
local normalCombat = Combat()
normalCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
normalCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
normalCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
normalCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
normalCombat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)
normalCombat:setArea(area)

-- Cria o combate crítico (pré-configurado)
local critCombat = Combat()
critCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
critCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
critCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
critCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
critCombat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1 * CRIT_CONFIG.multiplier, 0)
critCombat:setArea(area)

function onUseWeapon(player, variant)
    if player:getSkull() == SKULL_BLACK then
        return false
    end

    -- Verifica se é um crítico
    local weapon = player:getSlotItem(CONST_SLOT_LEFT) or player:getSlotItem(CONST_SLOT_RIGHT)
    if weapon and CRIT_WEAPONS[weapon:getId()] and math.random(100) <= CRIT_WEAPONS[weapon:getId()] then
        player:say(CRIT_CONFIG.message, TALKTYPE_MONSTER_SAY)
        return critCombat:execute(player, variant)
    end

    return normalCombat:execute(player, variant)
end