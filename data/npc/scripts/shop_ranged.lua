-- shop_ranged.lua

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
  { text = "Ranged weapons and ammo for sale! Check my stock!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- buyable
shopModule:addSellableItem({'bow'},                 2456,     200, 'bow')
shopModule:addBuyableItem({'spear'},           		2389,  300, 1, 'spear')
shopModule:addBuyableItem({'hunting spear'},    	3965,  5000, 1, 'hunting spear')
shopModule:addBuyableItem({'throwing knives'}, 	 	2410,  2000, 1, 'throwing knives')
shopModule:addBuyableItem({'arrow'},            	2544,   100, 1, 'arrow')
shopModule:addBuyableItem({'bolt'},             	2543,   200, 1, 'bolt')
--shopModule:addBuyableItem({'power bolt'},       	2547,   30, 1, 'power bolt')
--shopModule:addBuyableItem({'piercing bolt'},    	7363,    3, 1, 'piercing bolt')
--shopModule:addBuyableItem({'infernal bolt'},    	6529,    4, 1, 'infernal bolt')
--shopModule:addBuyableItem({'onyx arrow'},       	7365,    4, 1, 'onyx arrow')
shopModule:addBuyableItem({'throwing star'},     	2399,    4000, 1, 'throwing star')
shopModule:addBuyableItem({'sniper arrow'},     	7364,    4000, 1, 'sniper arrow')
--shopModule:addBuyableItem({'shiver arrow'},     	7839,    1, 1, 'shiver arrow')
--shopModule:addBuyableItem({'flash arrow'},      	7838,    2, 1, 'flash arrow')
--shopModule:addBuyableItem({'flaming arrow'},    	7840,    3, 1, 'flaming arrow')
shopModule:addBuyableItem({'crossbow'},         	2455,  150, 1, 'crossbow')
shopModule:addBuyableItem({'slingshot'},        	5907,   50, 1, 'slingshot')

-- sellable
shopModule:addSellableItem({'bow'},                 2456,    50, 'bow')
shopModule:addSellableItem({'buriza'},              8852,150000, 'buriza')
shopModule:addSellableItem({'churchills bow'},      8856,200000, 'churchills bow')
shopModule:addSellableItem({'crystal arrow'},       2352,  20000, 'crystal arrow')
shopModule:addSellableItem({'eaglehorn'},           8855,  200000, 'eaglehorn')
shopModule:addSellableItem({'elven bow'},           7438, 10000, 'elven bow')
shopModule:addSellableItem({'arbalest'},			5803,60000, 'arbalest')
shopModule:addSellableItem({'lomelindi'},      		5947, 25000, 'lomelindi')
shopModule:addSellableItem({'royal spear'},         7378,  5000, 'royal spear')
shopModule:addSellableItem({'warsinger bow'},       8854, 30000, 'warsinger bow')
shopModule:addSellableItem({'viper star'},          7366,    7000, 'viper star')
shopModule:addSellableItem({'assassin star'},       7368,    15000, 'assassin star')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} or {sell} ranged weapons and ammo here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
