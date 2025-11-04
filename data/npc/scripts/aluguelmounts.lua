local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, 'dsijdisjdosjdosjdsodosfdykslnfsdklfsdjku') then
		npcHandler:say('We can bring you to Thais with one of our coaches for 125 gold. Are you interested?', cid)
		npcHandler.topic[cid] = 1
	elseif isInArray({'aluguel','alugar', 'rent', 'mounts', 'mount', 'montaria', 'montarias', 'cavalos', 'cavalo'}, msg) then
		npcHandler:say('Voce quer alugar um cavalo por 10000 gold?', cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, 'yes') then
		local player = Player(cid)
		if npcHandler.topic[cid] == 1 then
			if player:isPzLocked() then
				npcHandler:say('Primeiro se livrar dessas manchas de sangue!', cid)
				return true
			end

			if not player:removeMoney(125) then
				npcHandler:say('Voce nao tem dinheiro suficiente', cid)
				return true
			end

		elseif npcHandler.topic[cid] == 2 then
			if player:getStorageValue(Storage.RentedHorseTimer) >= os.time() then
				npcHandler:say('Voce ja está alugando um cavalo.', cid)
				return true
			end

			if not player:removeMoney(10000) then
				npcHandler:say('Voce nao tem dinheiro suficiente para alugar um cavalo.', cid)
				return true
			end

			local mountId = {22, 25, 26}
			player:addMount(mountId[math.random(#mountId)])
			player:setStorageValue(Storage.RentedHorseTimer, os.time() + 86400)
			npcHandler:say('Eu irei dar-lhe um dos nossos mais experientes cavalos. Cuidado! Olhe para os galhos baixos.', cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
		npcHandler:say('Sem problemas, precisando estou aqui', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
