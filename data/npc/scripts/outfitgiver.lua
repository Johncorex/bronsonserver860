local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local outfits = {
	[0] = { -- Feminino
		{lookType = 136, addons = 0}, {lookType = 137, addons = 0},
		{lookType = 138, addons = 0}, {lookType = 139, addons = 0},
		{lookType = 140, addons = 0}, {lookType = 141, addons = 0},
		{lookType = 142, addons = 0}, {lookType = 147, addons = 0},
		{lookType = 148, addons = 0}, {lookType = 149, addons = 0},
		{lookType = 150, addons = 0}, {lookType = 155, addons = 0},
		{lookType = 157, addons = 0}, {lookType = 158, addons = 0},
	},

	[1] = { -- Masculino
		{lookType = 128, addons = 0}, {lookType = 129, addons = 0},
		{lookType = 130, addons = 0}, {lookType = 131, addons = 0},
		{lookType = 132, addons = 0}, {lookType = 133, addons = 0},
		{lookType = 134, addons = 0}, {lookType = 143, addons = 0},
		{lookType = 144, addons = 0}, {lookType = 145, addons = 0},
		{lookType = 146, addons = 0}, {lookType = 151, addons = 0},
		{lookType = 153, addons = 0}, {lookType = 154, addons = 0},
	}
}

local storageBase = 30000

function onCreatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if not player then
		return false
	end

	msg = msg:lower()

	if msgcontains(msg, "outfit") then
		local sex = player:getSex()
		local count = 0

		for _, outfit in ipairs(outfits[sex]) do
			local storageId = storageBase + outfit.lookType
			if player:getStorageValue(storageId) ~= 1 then
				player:addOutfit(outfit.lookType)
				player:addOutfit(outfit.lookType, outfit.addons)
				player:setStorageValue(storageId, 1)
				count = count + 1
			end
		end

		if count > 0 then
			npcHandler:say("Voce recebeu " .. count .. " outfits novos!", cid)
		else
			npcHandler:say("Voce ja possui todos os outfits que posso oferecer.", cid)
		end
		npcHandler:releaseFocus(cid)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, onCreatureSayCallback)
npcHandler:addModule(FocusModule:new())
