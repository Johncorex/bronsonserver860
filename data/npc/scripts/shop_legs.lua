-- shop_legs.lua

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
  { text = "Legs and kilts for sale! Take a look!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'leather legs'},         2649,   16,    1, 'leather legs')
shopModule:addBuyableItem({'studded legs'},         2468,   70,    1, 'studded legs')
shopModule:addBuyableItem({'chain legs'},           2648,  250,    1, 'chain legs')
shopModule:addBuyableItem({'brass legs'},           2478,  600,    1, 'brass legs')
shopModule:addBuyableItem({'mammoth fur shorts'},   7464,  600,    1, 'mammoth fur shorts')
shopModule:addBuyableItem({'plate legs'},           2647, 4000,    1, 'plate legs')
shopModule:addBuyableItem({'pirate knee breeches'}, 5918, 4400,    1, 'pirate knee breeches')
shopModule:addBuyableItem({'elven legs'},           2507, 8000,    1, 'elven legs')
shopModule:addBuyableItem({'aghanim legs'},         7895,36000,    1, 'aghanim legs')
shopModule:addBuyableItem({'dwarven legs'},         2504,13000,    1, 'dwarven legs')
shopModule:addBuyableItem({'glacier kilt'},         7896,14000,    1, 'glacier kilt')
shopModule:addBuyableItem({'terra legs'},           7885,34000,    1, 'terra legs')
shopModule:addBuyableItem({'knight legs'},          2477,24000,    1, 'knight legs')

-- itens para vender
shopModule:addSellableItem({'ornate legs'},         15412,350000, 'ornate legs')
shopModule:addSellableItem({'depth ocrea'},         15409, 90000, 'depth ocrea')
shopModule:addSellableItem({'blue legs'},           7730,150000, 'blue legs')
shopModule:addSellableItem({'prismatic legs'},      18405, 60000, 'prismatic legs')
shopModule:addSellableItem({'grasshopper legs'},    15490, 10000, 'grasshopper legs')
shopModule:addSellableItem({'gill legs'},           18400, 70000, 'gill legs')
shopModule:addSellableItem({'leather legs'},        2649,     8, 'leather legs')
shopModule:addSellableItem({'studded legs'},        2468,    35, 'studded legs')
shopModule:addSellableItem({'chain legs'},          2648,   125, 'chain legs')
shopModule:addSellableItem({'brass legs'},          2478,   300, 'brass legs')
shopModule:addSellableItem({'mammoth fur shorts'},  7464,   300, 'mammoth fur shorts')
shopModule:addSellableItem({'plate legs'},          2647,  2000, 'plate legs')
shopModule:addSellableItem({'pirate knee breeches'},5918, 2200, 'pirate knee breeches')
shopModule:addSellableItem({'elven legs'},          2507,  4000, 'elven legs')
shopModule:addSellableItem({'aghanim legs'},        7895, 18000, 'aghanim legs')
shopModule:addSellableItem({'dwarven legs'},        2504,  6500, 'dwarven legs')
shopModule:addSellableItem({'glacier kilt'},        7896,  7000, 'glacier kilt')
shopModule:addSellableItem({'terra legs'},          7885, 17000, 'terra legs')
shopModule:addSellableItem({'knight legs'},         2477, 12000, 'knight legs')
shopModule:addSellableItem({'magma legs'},          7894, 22000, 'magma legs')
shopModule:addSellableItem({'crown legs'},          2488, 22000, 'crown legs')
shopModule:addSellableItem({'dragon scale legs'},   2469, 35000, 'dragon scale legs')
shopModule:addSellableItem({'zenit legs'},          11304,42000, 'zenit legs')
shopModule:addSellableItem({'demon legs'},          2495, 60000, 'demon legs')
shopModule:addSellableItem({'valar kilt'},          9777,300000, 'valar kilt')
shopModule:addSellableItem({'golden legs'},         2470,300000, 'golden legs')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} legs and kilts here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
