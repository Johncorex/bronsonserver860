-- shop_swords.lua

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
  { text = "Swords and blades for sale! Have a look!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'rapier'},            2384,  30, 1, 'rapier')
shopModule:addBuyableItem({'short sword'},       2406,  50, 1, 'short sword')
shopModule:addBuyableItem({'sabre'},             2385,  80, 1, 'sabre')
shopModule:addBuyableItem({'bone sword'},        2450, 120, 1, 'bone sword')
shopModule:addBuyableItem({'sword'},             2376, 100, 1, 'sword')
shopModule:addBuyableItem({'katana'},            2412, 240, 1, 'katana')
shopModule:addBuyableItem({'heavy machete'},     2442,1900, 1, 'heavy machete')
shopModule:addBuyableItem({'long sword'},        2397, 450, 1, 'long sword')
shopModule:addBuyableItem({'poison dagger'},     2411,1500, 1, 'poison dagger')
shopModule:addBuyableItem({'scimitar'},          2419, 530, 1, 'scimitar')
shopModule:addBuyableItem({'templar scytheblade'},3963,800,1,'templar scytheblade')
shopModule:addBuyableItem({'broad sword'},       2413, 600, 1, 'broad sword')
shopModule:addBuyableItem({'spike sword'},       2383, 1400,1, 'spike sword')
shopModule:addBuyableItem({'serpent sword'},     2409, 1800,1, 'serpent sword')
shopModule:addBuyableItem({'two handed sword'},  2377,2400, 1, 'two handed sword')
shopModule:addBuyableItem({'wyvern fang'},       7408, 2800,1, 'wyvern fang')
shopModule:addBuyableItem({'sting'},             7404, 5400,1, 'sting')
shopModule:addBuyableItem({'fire sword'},        2392, 8000,1, 'fire sword')
shopModule:addBuyableItem({'bright sword'},      2407,11000,1, 'bright sword')
shopModule:addBuyableItem({'djin blade'},        2451,14000,1, 'djin blade')

-- itens para vender
shopModule:addSellableItem({'gladium aureum'},      8931,300000,'gladium aureum')
shopModule:addSellableItem({'shiny blade'},        18465,300000,'shiny blade')
--shopModule:addSellableItem({'dagorleaf'},           7405,200000,'dagorleaf')
shopModule:addSellableItem({'blade of corruption'},12649,140000,'blade of corruption')
shopModule:addSellableItem({'heavy trident'},       13838,70000, 'heavy trident')
shopModule:addSellableItem({'rapier'},              2384,   15,'rapier')
shopModule:addSellableItem({'short sword'},         2406,   25,'short sword')
shopModule:addSellableItem({'sabre'},               2385,   40,'sabre')
shopModule:addSellableItem({'bone sword'},          2450,   60,'bone sword')
shopModule:addSellableItem({'sword'},               2376,   50,'sword')
shopModule:addSellableItem({'katana'},              2412,  120,'katana')
shopModule:addSellableItem({'heavy machete'},       2442,  950,'heavy machete')
shopModule:addSellableItem({'long sword'},          2397,  225,'long sword')
shopModule:addSellableItem({'poison dagger'},       2411,  750,'poison dagger')
shopModule:addSellableItem({'scimitar'},            2419,  265,'scimitar')
shopModule:addSellableItem({'templar scytheblade'}, 3963,  400,'templar scytheblade')
shopModule:addSellableItem({'broad sword'},         2413,  300,'broad sword')
shopModule:addSellableItem({'spike sword'},         2383,  700,'spike sword')
shopModule:addSellableItem({'serpent sword'},       2409,  900,'serpent sword')
shopModule:addSellableItem({'two handed sword'},    2377, 1200,'two handed sword')
shopModule:addSellableItem({'wyvern fang'},         7408, 1400,'wyvern fang')
shopModule:addSellableItem({'sting'},               7404, 2700,'sting')
shopModule:addSellableItem({'fire sword'},          2392, 4000,'fire sword')
shopModule:addSellableItem({'bright sword'},        2407, 5500,'bright sword')
shopModule:addSellableItem({'djin blade'},          2451, 7000,'djin blade')
shopModule:addSellableItem({'pharao sword'},        2446,13000,'pharao sword')
shopModule:addSellableItem({'mercenary sword'},     7386,13000,'mercenary sword')
shopModule:addSellableItem({'emerald sword'},       8930,15000,'emerald sword')
shopModule:addSellableItem({'haunted blade'},       7407,18000,'haunted blade')
shopModule:addSellableItem({'the herugrin'},        7391,20000,'the herugrin')
shopModule:addSellableItem({'giant sword'},         2393,25000,'giant sword')
shopModule:addSellableItem({'demonrage sword'},     7382,50000,'demonrage sword')
shopModule:addSellableItem({'magic sword'},         2400,75000,'magic sword')
shopModule:addSellableItem({'chaos blade'},         11307,85000,'chaos blade')
shopModule:addSellableItem({'warlord sword'},       2408,100000,'warlord sword')
shopModule:addSellableItem({'anduril'},             2390,200000,'anduril')
shopModule:addSellableItem({'narsil'},              6528,400000,'narsil')
shopModule:addSellableItem({'dragon slayer'},       7402, 16000,'dragon slayer')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','sell','buy'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} swords here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
