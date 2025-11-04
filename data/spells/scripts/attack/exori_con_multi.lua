local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_INFERNALBOLT, CONST_ANI_INFERNALBOLT)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, 3)

function onGetFormulaValues(player, skill, attack, factor)
	local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = (player:getLevel() / 2.4) + (((distanceSkill * 2.5) * (attack * 0.7) * 0.026) + 70) 
	local max = (player:getLevel() / 2.3) + (((distanceSkill * 3.0) * (attack * 0.7) * 0.033) + 95) 
	return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    local target = variantToNumber(var)
    if not isCreature(target) then
        return false
    end

    -- Função auxiliar para executar ataque e disparar flecha com delay
    local function executeAttack(delay)
        addEvent(function()
            if isCreature(cid) and isCreature(target) then
                doCombat(cid, combat, numberToVariant(target))
            end
        end, delay)
    end

    -- Disparos nos tempos definidos
    executeAttack(150)
    executeAttack(550)
    executeAttack(950)

    return true
end
