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
	if msgcontains(msg, 'mok') then
		if getPlayerStorageValue(cid, 587433) <= 0 then
			selfSay('Maruk Omark Ferut Bata Gandalf.', cid)
			return end
			if getPlayerStorageValue(cid, 587433) >= 0 then
			pos = {x=1629, y=1150, z=8}
			doTeleportThing(cid, pos)
			return end
	end
	
	if msgcontains(msg, 'yes') then
	selfSay('no falo su lingua.', cid)
	return end
	
	if msgcontains(msg, 'no') then
	selfSay('no falo su lingua.', cid)
	return end
	
	if msgcontains(msg, 'futchi') then
	selfSay('Fetchi maruk buta!', cid)
	return end
	
	if msgcontains(msg, 'Burp') then
	selfSay('Fetchi maruk buta!', cid)
	return end
	
	
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())