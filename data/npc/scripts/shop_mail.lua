-- shop_mail.lua

local keywordHandler = KeywordHandler:new()
local npcHandler     = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- eventos basicos
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)    end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                npcHandler:onThink()                end

-- vozes automaticas
local voices = {
  { text = "Sistema de parcels esta fora do ar, desculpe o imprevisto." }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
--shopModule:addBuyableItem({'parcel'}, 2595, 15, 1, 'parcel')
--shopModule:addBuyableItem({'letter'}, 2597, 10, 1, 'letter')
--shopModule:addBuyableItem({'label'}, 2599, 5, 1, 'label')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} parcels and letters here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
