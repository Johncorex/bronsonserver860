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
normalCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISONARROW)
normalCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
normalCombat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)

-- Cria o combate crítico
local critCombat = Combat()
critCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
critCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISONARROW)
critCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
critCombat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1 * CRIT_CONFIG.multiplier, 0)

function onUseWeapon(player, variant)
    -- Verifica se é um crítico
    local weapon = player:getSlotItem(CONST_SLOT_LEFT) or player:getSlotItem(CONST_SLOT_RIGHT)
    local isCritical = weapon and CRIT_WEAPONS[weapon:getId()] and math.random(100) <= CRIT_WEAPONS[weapon:getId()]
    
    -- Executa o combate apropriado
    local combatToUse = isCritical and critCombat or normalCombat
    if not combatToUse:execute(player, variant) then
        return false
    end

    -- Aplica o veneno (condição original)
    local target = Creature(variant:getNumber())
    if target then
        player:addDamageCondition(target, CONDITION_POISON, DAMAGELIST_LOGARITHMIC_DAMAGE, 10)
        
        -- Mostra mensagem se for crítico
        if isCritical then
            player:say(CRIT_CONFIG.message, TALKTYPE_MONSTER_SAY)
        end
    end

    return true
end