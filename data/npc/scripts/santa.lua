local gifts = {
        {10, 10521, 1}, -- 1% to get Moon Backpack [20]          
        {70, 6512, 1}, -- 7% to get Santa Doll [70]        
        {100, 11255, 1}, -- 10% to get Santa Teddy [100]
        {300, 2173, 1}, -- 30% to get Amulet of loss [300]
        {500, 2688, 10}, -- 50% to get 10 Candy Canes [500]
} 

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                  npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)              npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)          npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                              npcHandler:onThink() end

function SantaNPC(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    

if getPlayerLevel(cid) < 50 then
			
				selfSay('Desculpe, mas Voce precisa ser no minimo level 50 para receber seu presente!', cid)
				return false
end


if (parameters.present == true) then
        if (getPlayerStorageValue(cid, 1587583) == 1) then
      selfSay("Voce ja recebeu seu presente de natal.", cid)
      return true
  end

        local item = {}
        local reward = 0
        local count = ""
        for i = 1, #gifts do
            item = gifts[i]
            if (math.random(0,999) < item[1]) then
                reward = item[2]
                subType = item[3]
                if subType > 1 then
                    count = subType .. " "
                end
                break
            end
        end
        doPlayerAddItem(cid, reward, subType)
        setPlayerStorageValue(cid, 1587583, 1)
        npcHandler:say('HO-HO-HO! Tenho ' .. count .. getItemName(reward) .. ' para Voce :).', cid)
       return true
else
        npcHandler:say('nao entrego presentes para mal comportados...', cid)
    end
    npcHandler:resetNpc()
    return true
end

npcHandler:setMessage(MESSAGE_GREET, "HO-HO-HO, Feliz Natal |PLAYERNAME|. Eu tenho algo especial para Voce")

local noNode = KeywordNode:new({'no'}, SantaNPC, {present = false})
local yesNode = KeywordNode:new({'yes'}, SantaNPC, {present = true})

local node = keywordHandler:addKeyword({'presente'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce se comportou bem esse ano ?'})
    node:addChildKeywordNode(yesNode)
    node:addChildKeywordNode(noNode)

npcHandler:addModule(FocusModule:new())