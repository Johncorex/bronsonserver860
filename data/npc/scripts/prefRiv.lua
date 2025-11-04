local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if(msgcontains(msg, 'sim')) or (msgcontains(msg, 'yes')) then
	if (getPlayerVocation(cid) >= 1 and getPlayerVocation(cid) <= 22 ) or (getPlayerVocation(cid) >= 28 and getPlayerVocation(cid) <= 32 ) or getPlayerVocation(cid) == 33 then
    npcHandler:say('Voce nao e bem vindo aqui.', cid) return true
    end		
			doPlayerSetTown(cid, 3)
		npcHandler:say("Seja bem vindo a Rivendell.", cid)
		talkState[talkUser] = 1
		
	elseif(msgcontains(msg, 'nao')) or (msgcontains(msg, 'no'))  then
		npcHandler:say('Adeus Forasteiro..', cid)
		talkState[talkUser] = 0
		
	end

	return true
end

function msgcontains(message, keyword)
	if(type(keyword) == "table") then
		return table.isStrIn(keyword, message)
	end

	local a, b = message:lower():find(keyword:lower())
	if(a ~= nil and b ~= nil) then
		return true
	end

	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
