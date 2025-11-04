-- shop_clubs.lua

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
  { text = "Clubs, hammers and maces for sale! Check my stock!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'club'},               2382,    16, 1, 'club')
shopModule:addBuyableItem({'studded club'},       2448,    20, 1, 'studded club')
shopModule:addBuyableItem({'bone club'},          2449,    50, 1, 'bone club')
shopModule:addBuyableItem({'mace'},               2398,    90, 1, 'mace')
shopModule:addBuyableItem({'daramanian mace'},    2439,   300, 1, 'daramanian mace')
shopModule:addBuyableItem({'battle hammer'},      2417,   700, 1, 'battle hammer')
shopModule:addBuyableItem({'mammoth whopper'},    7381,  1600, 1, 'mammoth whopper')
shopModule:addBuyableItem({'morning star'},       2394,  1100, 1, 'morning star')
shopModule:addBuyableItem({'banana staff'},       3966,  1400, 1, 'banana staff')
shopModule:addBuyableItem({'clerical mace'},      2423,  1800, 1, 'clerical mace')
shopModule:addBuyableItem({'dragon hammer'},      2434,  5000, 1, 'dragon hammer')
shopModule:addBuyableItem({'skull staff'},        2436,  8000, 1, 'skull staff')
shopModule:addBuyableItem({'sapphire hammer'},    7437, 10000, 1, 'sapphire hammer')
shopModule:addBuyableItem({'chaos mace'},         7427, 30000, 1, 'chaos mace')
shopModule:addBuyableItem({'crystal mace'},       2445, 20000, 1, 'crystal mace')
shopModule:addBuyableItem({'diamond sceptre'},    7387, 50000, 1, 'diamond sceptre')

-- itens para vender
shopModule:addSellableItem({'mjolnir'},           7882,300000, 'mjolnir')
shopModule:addSellableItem({'ornate mace'},      15414,300000,'ornate mace')
shopModule:addSellableItem({'maelstrom'},         7776,200000,'maelstrom')
shopModule:addSellableItem({'glamdring'},         7414,125000,'glamdring')
shopModule:addSellableItem({'demonbane'},         7431,125000,'demonbane')
shopModule:addSellableItem({'grond'},             7415,100000,'grond')
shopModule:addSellableItem({'thunder hammer'},    2421, 60000,'thunder hammer')
shopModule:addSellableItem({'heavy mace'},        2452, 35000,'heavy mace')
shopModule:addSellableItem({'hammer of wrath'},   2444, 30000,'hammer of wrath')
shopModule:addSellableItem({'spiked squelcher'},  7452, 22000,'spiked squelcher')
shopModule:addSellableItem({'drachaku'},         11308, 35000,'drachaku')
shopModule:addSellableItem({'war hammer'},        2391, 18000,'war hammer')
shopModule:addSellableItem({'silver mace'},       2424, 18000,'silver mace')
shopModule:addSellableItem({'club'},               2382,     8,'club')
shopModule:addSellableItem({'studded club'},       2448,    10,'studded club')
shopModule:addSellableItem({'bone club'},          2449,    25,'bone club')
shopModule:addSellableItem({'mace'},               2398,    45,'mace')
shopModule:addSellableItem({'daramanian mace'},    2439,   150,'daramanian mace')
shopModule:addSellableItem({'battle hammer'},      2417,   350,'battle hammer')
shopModule:addSellableItem({'mammoth whopper'},    7381,   800,'mammoth whopper')
shopModule:addSellableItem({'morning star'},       2394,   550,'morning star')
shopModule:addSellableItem({'banana staff'},       3966,   700,'banana staff')
shopModule:addSellableItem({'clerical mace'},      2423,   900,'clerical mace')
shopModule:addSellableItem({'dragon hammer'},      2434,  2500,'dragon hammer')
shopModule:addSellableItem({'skull staff'},        2436,  4000,'skull staff')
shopModule:addSellableItem({'sapphire hammer'},    7437,  5000,'sapphire hammer')
shopModule:addSellableItem({'chaos mace'},         7427, 15000,'chaos mace')
shopModule:addSellableItem({'crystal mace'},       2445, 10000,'crystal mace')
shopModule:addSellableItem({'diamond sceptre'},    7387, 25000,'diamond sceptre')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} clubs, hammers and maces here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
