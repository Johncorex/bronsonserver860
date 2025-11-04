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
			selfSay('Voce ainda nao ajudou Gandalf, O Cinzento procure-o.', cid)
			return end
			if getPlayerStorageValue(cid, 587427) <= 0 then
			selfSay('Voce ainda nao ajdou Thorin, procure-o.', cid)
			return end
			
			if getPlayerStorageValue(cid, 587430) > 0  then
			selfSay('Voce ja fez sua parte, agora procure Frodo.', cid)
			return end
			
			
			if getPlayerStorageValue(cid, 587429) > 0  then
			selfSay('Voce precisa matar Saruman.', cid)
			return end
					
		
			if getPlayerLevel(cid) >= 250 then
					setPlayerStorageValue(cid, 587429, 1)
					selfSay('Preciso que Voce me ajude a derrotar o Saruman, após isso volte aqui.', cid)
				else
					selfSay('Voce precisa ser level 250 ou mais para me ajudar!', cid)
	
			end
	end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())