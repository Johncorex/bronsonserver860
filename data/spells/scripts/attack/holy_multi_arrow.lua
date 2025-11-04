local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SHIVERARROW, CONST_ANI_SHIVERARROW)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, 3)

function onGetFormulaValues(cid, level, skill, attack, factor)
    local distanceSkill = getPlayerSkillLevel(cid, SKILL_DISTANCE)
    local magicLevel = getPlayerMagLevel(cid)

    local min = (level / 5) + distanceSkill * 0.7 + magicLevel * 1.5 +10
    local max = (level / 5) + distanceSkill + magicLevel * 2.5 + 15

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
                -- Delay separado para efeito visual da flecha extra
                addEvent(function()
                    if isCreature(cid) and isCreature(target) then
                        doSendDistanceShoot(getCreaturePosition(cid), getCreaturePosition(target), CONST_ANI_SMALLHOLY)
                    end
                end, 5) -- Delay de 100ms após o dano
            end
        end, delay)
    end

    -- Disparos nos tempos definidos
    executeAttack(150)
    executeAttack(580)
    executeAttack(1030)

    return true
end
