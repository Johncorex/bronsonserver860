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
			selfSay('Voce precisa falar com Gandalf Cinzento.', cid)
			return end
			if getPlayerStorageValue(cid, 587427) <= 0 then
			selfSay('Voce precisa falar com Thorin.', cid)
			return end
			if getPlayerStorageValue(cid, 587430) <= 0 then
			selfSay('Voce precisa falar com Gandalf Branco.', cid)
			return end
			if getPlayerStorageValue(cid, 587433) > 0 then
			selfSay('Voce ja fez sua parte, agora Voce ja pode matar o grande Sauron.', cid)
			return end
			
			if getPlayerStorageValue(cid, 587432) >  0 and  getPlayerItemCount(cid,22543) >= 1 then
			setPlayerStorageValue(cid, 587433, 1)
			doPlayerRemoveItem(cid, 22543,1)
			selfSay('Muito obrigado, agora Voce pode finalmente derrotar o grande Sauron.', cid)
			return end
			if getPlayerItemCount(cid,22543) >= 1 then
			selfSay('Vi que Voce ja pegou o anel de sauron, agora mate o Gollum.', cid)
			return end
			if getPlayerStorageValue(cid, 587432) > 0 then
			selfSay('Vi que Voce ja matou o Gollum, agora pegue o Anel de Sauron com Gollum.', cid)
			return end
			if getPlayerStorageValue(cid, 587431) > 0 then
			selfSay('Por favor Nobre guerreiro, mate o Gollum ao sudoeste de edoras e pegue o Anel de Sauron.', cid)
			return end
				
		
		
			if getPlayerLevel(cid) >= 250 then
					setPlayerStorageValue(cid, 587431, 1)
					selfSay('Agora, vamos combater o Gollun aquele terrível e desprezível ladrão de aneis!, ouvir boatos que ele estava escondido ao sudoeste de edoras.', cid)
				else
					selfSay('Voce precisa ser level 250 ou mais para me ajudar!', cid)
	
			end
	end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())