local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setArea(createCombatArea(AREA_BEAM8))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 8.8) + 35
	local max = (level / 5) + (magicLevel * 12) + 70
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
