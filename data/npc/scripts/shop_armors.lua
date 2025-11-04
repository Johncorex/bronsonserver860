-- shop_armors.lua

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
  { text = "Armors and cloaks for sale! Take a look!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'leather armor'},        2467,   30, 1, 'leather armor')
shopModule:addBuyableItem({'studded armor'},        2484,   50, 1, 'studded armor')
shopModule:addBuyableItem({'chain armor'},          2464,  300, 1, 'chain armor')
shopModule:addBuyableItem({'brass armor'},          2465,  300, 1, 'brass armor')
shopModule:addBuyableItem({'scale armor'},          2483, 1000, 1, 'scale armor')
shopModule:addBuyableItem({'native armor'},         2508, 1800, 1, 'native armor')
shopModule:addBuyableItem({'dark armor'},           2489, 1800, 1, 'dark armor')
shopModule:addBuyableItem({'plate armor'},          2463, 2800, 1, 'plate armor')
shopModule:addBuyableItem({'mammoth fur cape'},     7463, 2800, 1, 'mammoth fur cape')
shopModule:addBuyableItem({'glacier robe'},         7897,11000, 1, 'glacier robe')
shopModule:addBuyableItem({'elven armor'},          2505,12000, 1, 'elven armor')
shopModule:addBuyableItem({'greenwood coat'},       8869,12000, 1, 'greenwood coat')
shopModule:addBuyableItem({'blue robe'},            2656,14000, 1, 'blue robe')
shopModule:addBuyableItem({'dwarven armor'},        2503,16000, 1, 'dwarven armor')
shopModule:addBuyableItem({'noble armor'},          2486,18000, 1, 'noble armor')
shopModule:addBuyableItem({'amazon armor'},         2500,26000, 1, 'amazon armor')
shopModule:addBuyableItem({'knight armor'},         2476,34000, 1, 'knight armor')
shopModule:addBuyableItem({'terra mantle'},         7884,36000, 1, 'terra mantle')
shopModule:addBuyableItem({'crown armor'},          2487,40000, 1, 'crown armor')

-- itens para vender
shopModule:addSellableItem({'pestilence omega'},    8880,80000,   'pestilence omega')
shopModule:addSellableItem({'leather armor'},       2467,   15,   'leather armor')
shopModule:addSellableItem({'studded armor'},       2484,   25,   'studded armor')
shopModule:addSellableItem({'chain armor'},         2464,  150,   'chain armor')
shopModule:addSellableItem({'brass armor'},         2465,  150,   'brass armor')
shopModule:addSellableItem({'scale armor'},         2483,  500,   'scale armor')
shopModule:addSellableItem({'native armor'},        2508,  900,   'native armor')
shopModule:addSellableItem({'dark armor'},          2489,  900,   'dark armor')
shopModule:addSellableItem({'plate armor'},         2463, 1400,   'plate armor')
shopModule:addSellableItem({'mammoth fur cape'},    7463, 1400,   'mammoth fur cape')
shopModule:addSellableItem({'glacier robe'},        7897, 5500,   'glacier robe')
shopModule:addSellableItem({'elven armor'},         2505, 6000,   'elven armor')
shopModule:addSellableItem({'twilight veil legs'},  11355, 55000,   'twilight veil legs')
--shopModule:addSellableItem({'robe of enchanted twilight'},       8868, 60000,   'robe of enchanted twilight')
shopModule:addSellableItem({'greenwood coat'},      8869, 6000,   'greenwood coat')
shopModule:addSellableItem({'blue robe'},           2656, 7000,   'blue robe')
shopModule:addSellableItem({'dwarven armor'},       2503, 8000,   'dwarven armor')
shopModule:addSellableItem({'noble armor'},         2486, 9000,   'noble armor')
shopModule:addSellableItem({'amazon armor'},        2500,13000,   'amazon armor')
shopModule:addSellableItem({'knight armor'},        2476,17000,   'knight armor')
shopModule:addSellableItem({'dragon scale mail'},   2492,45000,   'dragon scale mail')
shopModule:addSellableItem({'golden armor'},   		2466,80000,   'golden armor')
shopModule:addSellableItem({'terra mantle'},        7884,18000,   'terra mantle')
shopModule:addSellableItem({'crown armor'},         2487,20000,   'crown armor')
shopModule:addSellableItem({'robe of the underworld'}, 8890,13000,'robe of the underworld')
shopModule:addSellableItem({'aghanim robe'},        7898,30000,   'aghanim robe')
shopModule:addSellableItem({'demon armor'},        2494,60000,   'demon armor')
shopModule:addSellableItem({'red robe'},            2655,22000,   'red robe')
shopModule:addSellableItem({'magma coat'},          7899,17000,   'magma coat')
shopModule:addSellableItem({'dark lords cape'},     8865,21000,   'dark lords cape')
shopModule:addSellableItem({'windborn colossus'},   8883,18000,   'windborn colossus')
shopModule:addSellableItem({'oceanborn colossus'},  8884,18000,   'oceanborn colossus')
shopModule:addSellableItem({'fireborn giant armor'}, 8881,30000,   'fireborn giant armor')
shopModule:addSellableItem({'earthborn titan armor'}, 8882,30000,   'earthborn titan armor')
shopModule:addSellableItem({'focus cape'},          8871, 8000,   'focus cape')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} armor and cloaks here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
