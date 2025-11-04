local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, magicLevel)
	local formula_min = ((level * 1.3 + magicLevel * 1.3) * 1.8 + 300)
	local formula_max = ((level * 1.5 + magicLevel * 1.5) * 1.8 + 300)
	
	if formula_max < formula_min then
		local tmp = formula_max
		formula_max = formula_min
		formula_min = tmp
	end

	return formula_min, formula_max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
