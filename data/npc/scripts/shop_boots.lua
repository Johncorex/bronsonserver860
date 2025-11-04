-- shop_boots.lua (Ephis)

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
  { text = "Boots for sale! Step right in!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'sandals'},       2642,   10, 1, 'sandals')
shopModule:addBuyableItem({'leather boots'}, 2643,   20, 1, 'leather boots')
shopModule:addBuyableItem({'pirate boots'},  5462, 7000, 1, 'pirate boots')

-- itens para vender
shopModule:addSellableItem({'sandals'},         2642,     7, 'sandals')
shopModule:addSellableItem({'leather boots'},   2643,    10, 'leather boots')
shopModule:addSellableItem({'crocodile boots'}, 3982,  3000, 'crocodile boots')
shopModule:addSellableItem({'terra boots'},     7886,  6000, 'terra boots')
shopModule:addSellableItem({'pirate boots'},    5462,  3000, 'pirate boots')
shopModule:addSellableItem({'steel boots'},     2645, 15000, 'steel boots')
shopModule:addSellableItem({'boots of haste'},  2195,  8000, 'boots of haste')
shopModule:addSellableItem({'soft boots'},      6132, 50000, 'soft boots')
shopModule:addSellableItem({'fur boots'},       7457,  4000, 'fur boots')
shopModule:addSellableItem({'glacier boots'},   7892, 14000, 'glacier boots')
shopModule:addSellableItem({'magma boots'},     7891, 18000, 'magma boots')
shopModule:addSellableItem({'zenit shoes'},    11303, 50000, 'zenit shoes')
shopModule:addSellableItem({'aghanim boots'},   7893, 25000, 'aghanim boots')
shopModule:addSellableItem({'dragon scale boots'},11118,50000,'dragon scale boots')
shopModule:addSellableItem({'firewalker boots'}, 9932,300000,'firewalker boots')
shopModule:addSellableItem({'golden boots'},    2646,500000, 'golden boots')
shopModule:addSellableItem({'crystal boots'},  11117,50000,  'crystal boots')
shopModule:addSellableItem({'draken boots'},   12646,70000,  'draken boots')
shopModule:addSellableItem({'guardian boots'}, 11240,70000,  'guardian boots')
shopModule:addSellableItem({'prismatic boots'},18406,50000, 'prismatic boots')
shopModule:addSellableItem({'depth calcei'},   15410,150000,'depth calcei')
shopModule:addSellableItem({'oriental shoes'},24637,10000, 'oriental shoes')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} boots here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
