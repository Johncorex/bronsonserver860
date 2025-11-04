local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- callback simples para mensagens
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    msg = msg:lower()

    if msgcontains(msg, "pumin") then
        npcHandler:say("Amigo... seguinte, o Adm desistiu de fazer essa parte e me deixou aqui preso e solitario, entao, vai.. vai logo e termina essa quest.", cid)
        npcHandler.topic[cid] = 0
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET,
    "Hello " .. (Player ~= nil and "|PLAYERNAME|" or "traveller") .. 
    ", welcome to the atrium of Pumin's Domain. We require some information from you before we can let you pass. Where do you want to go?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Me tira daqui!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Tchau amigo, nao esqueca de mim")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
