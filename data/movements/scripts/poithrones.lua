local config = {
	[25690] = {text = "Voce tocou o trono do Infernatil e absorveu um pouco do seu espirito.", effect = CONST_ME_FIREAREA, toPosition = Position(1481, 547, 15)},
	[25691] = {text = "Voce tocou o trono do Tafariel e absorveu um pouco do seu espirito.", effect = CONST_ME_MORTAREA, toPosition = Position(1330, 582, 15)},
	[25692] = {text = "Voce tocou o trono do Verminor e absorveu um pouco do seu espirito.", effect = CONST_ME_POISONAREA, toPosition = Position(1412, 664, 15)},
	[25693] = {text = "Voce tocou o trono do Apocalypse e absorveu um pouco do seu espirito.", effect = CONST_ME_EXPLOSIONAREA, toPosition = Position(1447, 604, 15)},
	[25694] = {text = "Voce tocou o trono do Bazir e absorveu um pouco do seu espirito.", effect = CONST_ME_MAGIC_GREEN, toPosition = Position(1317, 726, 13)},
	[25695] = {text = "Voce tocou o trono do Ashfalor e absorveu um pouco do seu espirito.", effect = CONST_ME_FIREAREA, toPosition = Position(1411, 645, 15)},
	[25696] = {text = "Voce tocou o trono do Pumin e absorveu um pouco do seu espirito.", effect = CONST_ME_MORTAREA, toPosition = Position(1357, 615, 15)} 
}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local throne = config[item.actionid]
	if not throne then
		return true
	end

	-- usa o próprio actionid como storage
	local storage = item.actionid

	if creature:getStorageValue(storage) ~= 1 then
		creature:setStorageValue(storage, 1)
		creature:getPosition():sendMagicEffect(throne.effect)
		creature:say(throne.text, TALKTYPE_MONSTER_SAY)
	else
		creature:teleportTo(throne.toPosition)
		creature:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		creature:say("Vaza!", TALKTYPE_MONSTER_SAY)
	end
	return true
end
