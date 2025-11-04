local combat = createCombatObject()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STUN)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)

function getSpellDamage(player, weaponSkill, weaponAttack, attackStrength)

	local maxWeaponDamage = weaponAttack * weaponSkill * 0.12 + player:getLevel()
	local minRoll = math.floor(maxWeaponDamage / 1.5)
	local maxRoll = math.floor(maxWeaponDamage)
	local damage  = -math.random(minRoll, maxRoll)
	
	return damage, damage --The random part of the formula has already been made, just return the normal damage
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "getSpellDamage")

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setFormula(-0.7, 0, -0.7, 0)
combat:addCondition(condition)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end


