local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 10)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SHIVERARROW)

-- Configurações básicas
local CRIT_MULTIPLIER = 2.0
local CRIT_MESSAGE = "CRITICAL!"
local MANA_LOST_MULTIPLIER = 0.04  -- Multiplicador da mana perdida

-- Arcos com crítico (ID: chance%)
local CRIT_BOWS = {
    [7438] = 4,   -- ELVEN BOW
    [8854] = 6,   -- WARSINGER BOW
    [8856] = 4,   -- CHURCHILLS BOW
    [8855] = 7,   -- Eaglehorn
    [8858] = 9    -- Elethriel's Elemental Bow
}

function onGetFormulaValues(player, skill, attack, factor)
    local distance = player:getSkillLevel(SKILL_DISTANCE)
    local magic = player:getMagicLevel()
    local mana = player:getMana()
    local maxMana = player:getMaxMana()
    
    -- Calcula a mana perdida absoluta e aplica o multiplicador
    local manaLostBonus = (maxMana - mana) * MANA_LOST_MULTIPLIER
    
    -- Fórmula com mana perdida
    local min = (distance * 1.5) + (magic * 4.0) + manaLostBonus
    local max = (distance * 1.8) + (magic * 4.8) + manaLostBonus

    -- Verifica se é crítico
    local weapon = player:getSlotItem(CONST_SLOT_LEFT) or player:getSlotItem(CONST_SLOT_RIGHT)
    if weapon and CRIT_BOWS[weapon:getId()] and math.random(100) <= CRIT_BOWS[weapon:getId()] then
        player:say(CRIT_MESSAGE, TALKTYPE_MONSTER_SAY)
        return -min * CRIT_MULTIPLIER, -max * CRIT_MULTIPLIER
    end

    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onUseWeapon(player, variant)
    return combat:execute(player, variant)
end