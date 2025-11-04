-- shop_shields.lua

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
  { text = "Shields for sale! Check my stock!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- buyable
shopModule:addBuyableItem({'wooden shield'},   2512,   10, 1, 'wooden shield')
shopModule:addBuyableItem({'studded shield'},  2526,   20, 1, 'studded shield')
shopModule:addBuyableItem({'brass shield'},    2511,   46, 1, 'brass shield')
shopModule:addBuyableItem({'plate shield'},    2510,   90, 1, 'plate shield')
shopModule:addBuyableItem({'black shield'},    2529,  170, 1, 'black shield')
shopModule:addBuyableItem({'copper shield'},   2530,  300, 1, 'copper shield')
shopModule:addBuyableItem({'bone shield'},     2541,  450, 1, 'bone shield')
shopModule:addBuyableItem({'steel shield'},    2509,  600, 1, 'steel shield')
shopModule:addBuyableItem({'battle shield'},   2513, 1200, 1, 'battle shield')
shopModule:addBuyableItem({'scarab shield'},   2540, 1400, 1, 'scarab shield')
shopModule:addBuyableItem({'dark shield'},     2521, 1600, 1, 'dark shield')
shopModule:addBuyableItem({'tortoise shield'}, 6131, 1800, 1, 'tortoise shield')
shopModule:addBuyableItem({'salamander shield'},3975,2800,1,'salamander shield')
shopModule:addBuyableItem({'dwarven shield'},  2525, 3000, 1, 'dwarven shield')
shopModule:addBuyableItem({'tusk shield'},     3973, 6000, 1, 'tusk shield')
shopModule:addBuyableItem({'ancient shield'},  2532, 8000, 1, 'ancient shield')
shopModule:addBuyableItem({'rose shield'},     2527,10000,1,'rose shield')
shopModule:addBuyableItem({'castle shield'},   2535,14000,1,'castle shield')
shopModule:addBuyableItem({'beholder shield'}, 2518,20000,1,'beholder shield')
shopModule:addBuyableItem({'griffin shield'},  2533,20000,1,'griffin shield')

-- sellable
shopModule:addSellableItem({'prismatic shield'},12644,300000,'prismatic shield')
shopModule:addSellableItem({'prismatic shield'},18410,150000,'prismatic shield')
shopModule:addSellableItem({'warriors shield'},15453, 30000,'warriors shield')
shopModule:addSellableItem({'wooden shield'},   2512,    5,'wooden shield')
shopModule:addSellableItem({'studded shield'},  2526,   10,'studded shield')
shopModule:addSellableItem({'brass shield'},    2511,   23,'brass shield')
shopModule:addSellableItem({'plate shield'},    2510,   45,'plate shield')
shopModule:addSellableItem({'black shield'},    2529,   85,'black shield')
shopModule:addSellableItem({'copper shield'},   2530,  150,'copper shield')
shopModule:addSellableItem({'bone shield'},     2541,  225,'bone shield')
shopModule:addSellableItem({'steel shield'},    2509,  300,'steel shield')
shopModule:addSellableItem({'battle shield'},   2513,  600,'battle shield')
shopModule:addSellableItem({'scarab shield'},   2540,  700,'scarab shield')
shopModule:addSellableItem({'dark shield'},     2521,  800,'dark shield')
shopModule:addSellableItem({'tortoise shield'}, 6131,  900,'tortoise shield')
shopModule:addSellableItem({'salamander shield'},3975,1400,'salamander shield')
shopModule:addSellableItem({'dwarven shield'},  2525, 1500,'dwarven shield')
shopModule:addSellableItem({'tusk shield'},     3973, 3000,'tusk shield')
shopModule:addSellableItem({'ancient shield'},  2532, 4000,'ancient shield')
shopModule:addSellableItem({'rose shield'},     2527, 5000,'rose shield')
shopModule:addSellableItem({'castle shield'},   2535, 7000,'castle shield')
shopModule:addSellableItem({'beholder shield'}, 2518,10000,'beholder shield')
shopModule:addSellableItem({'griffin shield'},  2533,10000,'griffin shield')
shopModule:addSellableItem({'guardian shield'}, 2515,12000,'guardian shield')
shopModule:addSellableItem({'dragon shield'},   2516,14000,'dragon shield')
shopModule:addSellableItem({'tower shield'},    2528,18000,'tower shield')
shopModule:addSellableItem({'crown shield'},    2519,22000,'crown shield')
shopModule:addSellableItem({'amazon shield'},   2537,25000,'amazon shield')
shopModule:addSellableItem({'medusa shield'},   2536,30000,'medusa shield')
shopModule:addSellableItem({'shield of honour'},2517,31000,'shield of honour')
shopModule:addSellableItem({'vampire shield'},  2534,35000,'vampire shield')
shopModule:addSellableItem({'tempest shield'},  2542,150000,'tempest shield')
shopModule:addSellableItem({'phoenix shield'},  2539,150000,'phoenix shield')
shopModule:addSellableItem({'demon shield'},    2520,50000,'demon shield')
shopModule:addSellableItem({'mastermind shield'},2514,80000,'mastermind shield')
shopModule:addSellableItem({'great shield'},    2522,250000,'great shield')
shopModule:addSellableItem({'blessed shield'},  2523,500000,'blessed shield')
shopModule:addSellableItem({'cerberus shield'}, 8906,1000000,'cerberus shield')
shopModule:addSellableItem({'spellbook of mind control'},8902,15000,'spellbook of mind control')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} shields here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
