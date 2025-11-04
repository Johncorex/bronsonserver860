-- shop_furniture.lua

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
  { text = "Furniture for sale! Everything 500 gold pieces!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'wooden chair'},        3901,   500, 1, 'wooden chair')
shopModule:addBuyableItem({'sofa chair'},          3902,   500, 1, 'sofa chair')
shopModule:addBuyableItem({'red cushioned chair'}, 3903,   500, 1, 'red cushioned chair')
shopModule:addBuyableItem({'green cushioned chair'},3904,  500, 1, 'green cushioned chair')
shopModule:addBuyableItem({'tusk chair'},          3905,   500, 1, 'tusk chair')
shopModule:addBuyableItem({'ivory chair'},         3906,   500, 1, 'ivory chair')
shopModule:addBuyableItem({'water-pipe'},          3907,   500, 1, 'water-pipe')
shopModule:addBuyableItem({'coal basin'},          3908,   500, 1, 'coal basin')
shopModule:addBuyableItem({'big table'},           3909,   500, 1, 'big table')
shopModule:addBuyableItem({'square table'},        3910,   500, 1, 'square table')
shopModule:addBuyableItem({'round table'},         3911,   500, 1, 'round table')
shopModule:addBuyableItem({'small table'},         3912,   500, 1, 'small table')
shopModule:addBuyableItem({'stone table'},         3913,   500, 1, 'stone table')
shopModule:addBuyableItem({'tusk table'},          3914,   500, 1, 'tusk table')
shopModule:addBuyableItem({'chest'},               3915,   500, 1, 'chest')
shopModule:addBuyableItem({'barrel'},              3916,   500, 1, 'barrel')
shopModule:addBuyableItem({'harp'},                3917,   500, 1, 'harp')
shopModule:addBuyableItem({'bird cage'},           3918,   500, 1, 'bird cage')
shopModule:addBuyableItem({'bamboo table'},        3919,   500, 1, 'bamboo table')
shopModule:addBuyableItem({'bamboo drawer'},       3920,   500, 1, 'bamboo drawer')
shopModule:addBuyableItem({'drawer'},              3921,   500, 1, 'drawer')
shopModule:addBuyableItem({'exotic flower'},       3922,   500, 1, 'exotic flower')
shopModule:addBuyableItem({'potted flower'},       3923,   500, 1, 'potted flower')
shopModule:addBuyableItem({'flower bowl'},         3924,   500, 1, 'flower bowl')
shopModule:addBuyableItem({'chest'},               3925,   500, 1, 'chest')
shopModule:addBuyableItem({'piano'},               3926,   500, 1, 'piano')
shopModule:addBuyableItem({'globe'},               3927,   500, 1, 'globe')
shopModule:addBuyableItem({'rocking chair'},       3928,   500, 1, 'rocking chair')
shopModule:addBuyableItem({'indoor plant'},        3929,   500, 1, 'indoor plant')
shopModule:addBuyableItem({'crate'},               3930,   500, 1, 'crate')
shopModule:addBuyableItem({'christmas tree'},      3931,   500, 1, 'christmas tree')
shopModule:addBuyableItem({'dresser'},             3932,   500, 1, 'dresser')
shopModule:addBuyableItem({'pendelum clock'},      3933,   500, 1, 'pendelum clock')
shopModule:addBuyableItem({'locker'},              3934,   500, 1, 'locker')
shopModule:addBuyableItem({'trough'},              3935,   500, 1, 'trough')
shopModule:addBuyableItem({'time table'},          3936,   500, 1, 'time table')
shopModule:addBuyableItem({'table lamp'},          3937,   500, 1, 'table lamp')
shopModule:addBuyableItem({'bookcase'},            3938,   500, 1, 'bookcase')
shopModule:addBuyableItem({'box'},                 5086,   500, 1, 'box')
shopModule:addBuyableItem({'box2'},                5087,   500, 1, 'box2')
shopModule:addBuyableItem({'barrel2'},             5088,   500, 1, 'barrel2')
shopModule:addBuyableItem({'big flowerpot'},       6114,   500, 1, 'big flowerpot')
shopModule:addBuyableItem({'large amphora'},       6115,   500, 1, 'large amphora')
shopModule:addBuyableItem({'tree stump'},          6372,   500, 1, 'tree stump')
shopModule:addBuyableItem({'mirror'},              6373,   500, 1, 'mirror')
shopModule:addBuyableItem({'large trunk'},         7503,   500, 1, 'large trunk')
shopModule:addBuyableItem({'goldfish bowl'},       7700,   500, 1, 'goldfish bowl')
shopModule:addBuyableItem({'tree stump2'},         7960,   500, 1, 'tree stump2')
shopModule:addBuyableItem({'cuckoo clock'},        7961,   500, 1, 'cuckoo clock')
shopModule:addBuyableItem({'telescope'},           7962,   500, 1, 'telescope')
shopModule:addBuyableItem({'furnace'},             8692,   500, 1, 'furnace')
shopModule:addBuyableItem({'blue tapestry'},       1872,   500, 1, 'blue tapestry')
shopModule:addBuyableItem({'green tapestry'},      1860,   500, 1, 'green tapestry')
shopModule:addBuyableItem({'orange tapestry'},     1866,   500, 1, 'orange tapestry')
shopModule:addBuyableItem({'pink tapestry'},       1857,   500, 1, 'pink tapestry')
shopModule:addBuyableItem({'red tapestry'},        1869,   500, 1, 'red tapestry')
shopModule:addBuyableItem({'white tapestry'},      1880,   500, 1, 'white tapestry')
shopModule:addBuyableItem({'yellow tapestry'},     1863,   500, 1, 'yellow tapestry')
shopModule:addBuyableItem({'small purple pillow'},1678,   500, 1, 'small purple pillow')
shopModule:addBuyableItem({'small green pillow'}, 1679,   500, 1, 'small green pillow')
shopModule:addBuyableItem({'small red pillow'},    1680,   500, 1, 'small red pillow')
shopModule:addBuyableItem({'small blue pillow'},   1681,   500, 1, 'small blue pillow')
shopModule:addBuyableItem({'small orange pillow'},1683,   500, 1, 'small orange pillow')
shopModule:addBuyableItem({'small turquiose pillow'},1684,500,1,'small turquiose pillow')
shopModule:addBuyableItem({'small white pillow'}, 1685,   500, 1, 'small white pillow')
shopModule:addBuyableItem({'heart pillow'},        1685,   500, 1, 'heart pillow')
shopModule:addBuyableItem({'blue pillow'},         1686,   500, 1, 'blue pillow')
shopModule:addBuyableItem({'red pillow'},          1687,   500, 1, 'red pillow')
shopModule:addBuyableItem({'green pillow'},        1688,   500, 1, 'green pillow')
shopModule:addBuyableItem({'yellow pillow'},       1689,   500, 1, 'yellow pillow')
shopModule:addBuyableItem({'round blue pillow'},   1690,   500, 1, 'round blue pillow')
shopModule:addBuyableItem({'round red pillow'},    1691,   500, 1, 'round red pillow')
shopModule:addBuyableItem({'round purple pillow'},1692,   500, 1, 'round purple pillow')
shopModule:addBuyableItem({'round turquiose pillow'},1693,500,1,'round turquiose pillow')
shopModule:addBuyableItem({'oval mirror'},          1845,   750, 1, 'oval mirror')
shopModule:addBuyableItem({'round mirror'},         1848,   750, 1, 'round mirror')
shopModule:addBuyableItem({'edged mirror'},         1851,   750, 1, 'edged mirror')
shopModule:addBuyableItem({'green bed'},            7904,  1000, 1, 'green bed')
shopModule:addBuyableItem({'red bed'},              7905,  1000, 1, 'red bed')
shopModule:addBuyableItem({'yellow bed'},           7906,  1000, 1, 'yellow bed')
shopModule:addBuyableItem({'bed removal'},          7907,  1000, 1, 'bed removal')
shopModule:addBuyableItem({'wooden stake'},         5941, 10000, 1, 'wooden stake')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} furniture here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
