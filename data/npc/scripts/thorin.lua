local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid



-- CONFIG --	
local player = Player(cid)
	if msgcontains(msg, 'yes') then
		if getPlayerStorageValue(cid, 587423) <= 0 then
			selfSay('Voce precisa falar com Gandalf.', cid)
			return end
			if getPlayerStorageValue(cid, 587428) > 0 then
			selfSay('Voce ja fez sua parte, agora procure Gandalf Branco.', cid)
			return end
			if getPlayerStorageValue(cid, 587427) >  0 and  getPlayerItemCount(cid,24850) >= 1 then
			selfSay('Obrigado, por devolver o bem mais precioso do meu povo, a Pedra de Arken.', cid)
			doPlayerRemoveItem(cid, 24850,1)
			setPlayerStorageValue(cid, 587428, 1)
			return end
			if getPlayerItemCount(cid,24850) >= 1 then
			selfSay('Vi que Voce ja pegou a Pedra de Arken, agora mate o Smaug.', cid)
			return end
			if getPlayerStorageValue(cid, 587427) > 0 then
			selfSay('Vi que Voce ja matou o Smaug, agora procure a Pedra de Arken nos tesouros.', cid)
			return end
			if getPlayerStorageValue(cid, 587426) > 0 then
			selfSay('Voce ja está nessa missão meu nobre guerreiro.', cid)
			return end
				
		
		
			if getPlayerLevel(cid) >= 250 then
					setPlayerStorageValue(cid, 587426, 1)
					selfSay('Muito bem meu nobre, vamos combater aquele terrível e desprezível dragão!', cid)
				else
					selfSay('Voce precisa ser level 250 ou mais para me ajudar!', cid)
	
			end
	end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())