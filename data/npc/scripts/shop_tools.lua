-- shop_tools.lua

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
shopModule:addBuyableItem({'shovel'},          2554,  20, 1, 'shovel')
shopModule:addBuyableItem({'rope'},            2120,  20, 1, 'rope')
shopModule:addBuyableItem({'fishing rod','rod'},2580,50, 1, 'fishing rod')
shopModule:addBuyableItem({'backpack'},        1988,  10, 1, 'backpack')
shopModule:addBuyableItem({'pick'},            2553,  20, 1, 'pick')
shopModule:addBuyableItem({'carpenter hammer'},2557,  30, 1, 'carpenter hammer')
shopModule:addBuyableItem({'iron hammer'},     2422, 100, 1, 'iron hammer')
--shopModule:addBuyableItem({'parcel'},          2595,  29, 1, 'parcel')
--shopModule:addBuyableItem({'label'},           2599,   1, 1, 'label')
--shopModule:addBuyableItem({'letter'},          2597,  20, 1, 'letter')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} tools and supplies here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
