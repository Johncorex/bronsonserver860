-- shop_axes.lua

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
  { text = "Axes and wargear! Check my stock!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'axe'},                     2386,   26, 1, 'axe')
shopModule:addBuyableItem({'hand axe'},                2380,   16, 1, 'hand axe')
shopModule:addBuyableItem({'hatchet'},                 2388,   50, 1, 'hatchet')
shopModule:addBuyableItem({'orcish axe'},              2428,  240, 1, 'orcish axe')
shopModule:addBuyableItem({'battle axe'},              2378,  450, 1, 'battle axe')
shopModule:addBuyableItem({'barbarian axe'},           2429, 1300, 1, 'barbarian axe')
shopModule:addBuyableItem({'ripper lance'},            3964, 2000, 1, 'ripper lance')
shopModule:addBuyableItem({'dwarven axe'},             2435, 2800, 1, 'dwarven axe')
shopModule:addBuyableItem({'knight axe'},              2430, 6000, 1, 'knight axe')
shopModule:addBuyableItem({'double axe'},              2387, 2600, 1, 'double axe')
shopModule:addBuyableItem({'halberd'},                 2381, 2200, 1, 'halberd')
shopModule:addBuyableItem({'frost razor'},             7455,12000, 1, 'frost razor')
shopModule:addBuyableItem({'daramanian waraxe'},       2440, 8000, 1, 'daramanian waraxe')
shopModule:addBuyableItem({'fire axe'},                2432,16000, 1, 'fire axe')
shopModule:addBuyableItem({'dreaded cleaver'},         7419,50000, 1, 'dreaded cleaver')
shopModule:addBuyableItem({'naginata'},                2426,14000, 1, 'naginata')

-- itens para vender
shopModule:addSellableItem({'axe'},                     2386,   13, 'axe')
shopModule:addSellableItem({'hand axe'},                2380,    8, 'hand axe')
shopModule:addSellableItem({'hatchet'},                 2388,   25, 'hatchet')
shopModule:addSellableItem({'orcish axe'},              2428,  120, 'orcish axe')
shopModule:addSellableItem({'battle axe'},              2378,  225, 'battle axe')
shopModule:addSellableItem({'barbarian axe'},           2429,  650, 'barbarian axe')
shopModule:addSellableItem({'ripper lance'},            3964, 1000, 'ripper lance')
shopModule:addSellableItem({'dwarven axe'},             2435, 1400, 'dwarven axe')
shopModule:addSellableItem({'knight axe'},              2430, 3000, 'knight axe')
shopModule:addSellableItem({'double axe'},              2387, 1300, 'double axe')
shopModule:addSellableItem({'halberd'},                 2381, 1200, 'halberd')
shopModule:addSellableItem({'frost razor'},             7455, 6000, 'frost razor')
shopModule:addSellableItem({'daramanian waraxe'},       2440, 4000, 'daramanian waraxe')
shopModule:addSellableItem({'fire axe'},                2432, 8000, 'fire axe')
shopModule:addSellableItem({'dreaded cleaver'},         7419,25000, 'dreaded cleaver')
shopModule:addSellableItem({'noble axe'},               7456, 8000, 'noble axe')
shopModule:addSellableItem({'naginata'},                2426, 7000, 'naginata')
shopModule:addSellableItem({'axe of maim'},             3962,20000, 'axe of maim')
shopModule:addSellableItem({'headchopper'},             7380,10000, 'headchopper')
shopModule:addSellableItem({'twin axe'},                2447,14000, 'twin axe')
shopModule:addSellableItem({'guardian halberd'},        2427,16000, 'guardian halberd')
shopModule:addSellableItem({'reapers axe'},             7420,25000, 'reapers axe')
shopModule:addSellableItem({'vile axe'},                7388,38000, 'vile axe')
shopModule:addSellableItem({'dragon lance'},            2414,22000, 'dragon lance')
shopModule:addSellableItem({'war axe'},                 2454,25000, 'war axe')
shopModule:addSellableItem({'ravagers axe'},            2443,30000, 'ravagers axe')
shopModule:addSellableItem({'ruthless axe'},            6553,35000, 'ruthless axe')
shopModule:addSellableItem({'stonecutters axe'},        2431,60000, 'stonecutters axe')
shopModule:addSellableItem({'great axe'},               2415,50000, 'great axe')
shopModule:addSellableItem({'dramborleg'},              7413,100000,'dramborleg')
shopModule:addSellableItem({'axe of frerin'},           7434,130000,'axe of frerin')
shopModule:addSellableItem({'durins axe'},              8924,150000,'durins axe')
shopModule:addSellableItem({'crystalline axe'},         18451,300000,'crystalline axe')
shopModule:addSellableItem({'battlefury'},              8925,300000,'battlefury')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} axes here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new(FocusModule:new()))
