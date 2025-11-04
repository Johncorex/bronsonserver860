-- shop_runes.lua

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
  { text = "Runes and spells for sale! Have a look!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'antidote'},               2266,  11, 1, 'antidote')
shopModule:addBuyableItem({'avalanche'},              2274,  30, 1, 'avalanche')
shopModule:addBuyableItem({'diamond dust'},           2276,  93, 1, 'diamond dust')
shopModule:addBuyableItem({'dharmas caos'},           2263, 125, 1, 'dharmas caos')
shopModule:addBuyableItem({'energy bomb'},            2262,  25, 1, 'energy bomb')
shopModule:addBuyableItem({'energy field'},           2277,  10, 1, 'energy field')
shopModule:addBuyableItem({'explosion'},              2313,  32, 1, 'explosion')
shopModule:addBuyableItem({'fireball'},               2302,   6, 1, 'fireball')
shopModule:addBuyableItem({'fire bomb'},              2305,  25, 1, 'fire bomb')
shopModule:addBuyableItem({'fire field'},             2301,  10, 1, 'fire field')
shopModule:addBuyableItem({'fire missile'},           2306,  90, 1, 'fire missile')
shopModule:addBuyableItem({'great fireball'},         2304,  19, 1, 'great fireball')
shopModule:addBuyableItem({'great fireball'},         2314,  45, 1, 'great fireball')
shopModule:addBuyableItem({'heavy magic missile'},    2311,  12, 1, 'heavy magic missile')
shopModule:addBuyableItem({'holy missile'},           2295,  90, 1, 'holy missile')
shopModule:addBuyableItem({'icicle'},                 2271,  12, 1, 'icicle')
shopModule:addBuyableItem({'intense healing'},        2265,  12, 1, 'intense healing')
shopModule:addBuyableItem({'light magic missile'},    2287,   3, 1, 'light magic missile')
shopModule:addBuyableItem({'paralyze'},               2278, 180, 1, 'paralyze')
shopModule:addBuyableItem({'poison bomb'},            2286,  25, 1, 'poison bomb')
shopModule:addBuyableItem({'poison field'},           2285,  10, 1, 'poison field')
shopModule:addBuyableItem({'rejuvenation'},           2272, 200, 1, 'rejuvenation')
shopModule:addBuyableItem({'sudden death'},           2268,  60, 1, 'sudden death')
shopModule:addBuyableItem({'ultimate healing'},       2273,  80, 1, 'ultimate healing')
shopModule:addBuyableItem({'blank rune'},             2260,  10, 1, 'blank rune')
shopModule:addBuyableItem({'magic wall rune'},        2293, 200, 1, 'magic wall rune')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} runes and spells here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
