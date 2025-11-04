-- shop_helmets.lua

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
  { text = "Helmets for all occasions! Take a look!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'brass helmet'},      2460,    50, 1, 'brass helmet')
shopModule:addBuyableItem({'chain helmet'},      2458,    30, 1, 'chain helmet')
shopModule:addBuyableItem({'crown helmet'},      2491, 12000, 1, 'crown helmet')
shopModule:addBuyableItem({'dark helmet'},       2490,   900, 1, 'dark helmet')
shopModule:addBuyableItem({'devil helmet'},      2462,  6000, 1, 'devil helmet')
shopModule:addBuyableItem({'dwarven helmet'},    2502,  2000, 1, 'dwarven helmet')
shopModule:addBuyableItem({'horseman helmet'},   3969,  2200, 1, 'horseman helmet')
shopModule:addBuyableItem({'iron helmet'},       2459,   900, 1, 'iron helmet')
shopModule:addBuyableItem({'krimhorn helmet'},   7461,  2200, 1, 'krimhorn helmet')
shopModule:addBuyableItem({'legion helmet'},     2480,   200, 1, 'legion helmet')
shopModule:addBuyableItem({'ragnir helmet'},     7462,  2200, 1, 'ragnir helmet')
shopModule:addBuyableItem({'soldier helmet'},    2481,   450, 1, 'soldier helmet')
shopModule:addBuyableItem({'steel helmet'},      2457,  2200, 1, 'steel helmet')
shopModule:addBuyableItem({'strange helmet'},    2479,  2400, 1, 'strange helmet')
shopModule:addBuyableItem({'terra hood'},        7903,  1800, 1, 'terra hood')
shopModule:addBuyableItem({'studded helmet'},    2482,    30, 1, 'studded helmet')
shopModule:addBuyableItem({'viking helmet'},     2473,   200, 1, 'viking helmet')

-- itens para vender
shopModule:addSellableItem({'diadem of twilight'},2499,  40000,'diadem of twilight')
shopModule:addSellableItem({'brass helmet'},      2460,    25, 'brass helmet')
shopModule:addSellableItem({'chain helmet'},      2458,    15, 'chain helmet')
shopModule:addSellableItem({'crown helmet'},      2491,  6000, 'crown helmet')
shopModule:addSellableItem({'crusader helmet'},   2497,  7000, 'crusader helmet')
shopModule:addSellableItem({'royal helmet'},  	  2498,  8000, 'royal helmet')
shopModule:addSellableItem({'warrior helmet'},    2475,  6000, 'warrior helmet')
shopModule:addSellableItem({'aghanim mask'},   	  7901,  20000, 'aghanim mask')
shopModule:addSellableItem({'dark helmet'},       2490,   450, 'dark helmet')
shopModule:addSellableItem({'devil helmet'},      2462,  3000, 'devil helmet')
shopModule:addSellableItem({'demon helmet'},      2493,  50000, 'demon helmet')
shopModule:addSellableItem({'dwarven helmet'},    2502,  1000, 'dwarven helmet')
shopModule:addSellableItem({'glacier mask'},      7902,  1200, 'glacier mask')
shopModule:addSellableItem({'horseman helmet'},   3969,  1100, 'horseman helmet')
shopModule:addSellableItem({'dragon scale helmet'},2506,  40000, 'dragon scale helmet')
shopModule:addSellableItem({'iron helmet'},       2459,   450, 'iron helmet')
shopModule:addSellableItem({'krimhorn helmet'},   7461,  1100, 'krimhorn helmet')
shopModule:addSellableItem({'legion helmet'},     2480,   100, 'legion helmet')
shopModule:addSellableItem({'magician hat'},      2323,  2500, 'magician hat')
shopModule:addSellableItem({'mystic turban'},     2663,   250, 'mystic turban')
shopModule:addSellableItem({'ragnir helmet'},     7462,  1100, 'ragnir helmet')
shopModule:addSellableItem({'soldier helmet'},    2481,   225, 'soldier helmet')
shopModule:addSellableItem({'steel helmet'},      2457,  1100, 'steel helmet')
shopModule:addSellableItem({'strange helmet'},    2479,  1200, 'strange helmet')
shopModule:addSellableItem({'terra hood'},        7903,   900, 'terra hood')
shopModule:addSellableItem({'studded helmet'},    2482,    15, 'studded helmet')
shopModule:addSellableItem({'viking helmet'},     2473,   100, 'viking helmet')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} helmets here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
