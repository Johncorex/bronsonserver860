-- shop_potions.lua

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
  { text = "Mana potions for sale! Stock up your mana!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'strong mana potion','strong mana'},      7589,  280, 1, 'strong mana potion')
shopModule:addBuyableItem({'great mana potion'},                           7590,  480, 1, 'great mana potion')
shopModule:addBuyableItem({'mana potion','mana'},                  7620,  100, 1, 'mana potion')
shopModule:addBuyableItem({'great spirit potion'},                  8472,  380, 1, 'great spirit potion')

shopModule:addBuyableItem({'health potion'},             7618,  80, 1, 'health potion')
shopModule:addBuyableItem({'strong health potion'},             7588,  250, 1, 'strong health potion')
shopModule:addBuyableItem({'great health potion'},             7591,  430, 1, 'great health potion')
shopModule:addBuyableItem({'ultimate health potion'},             8473,  700, 1, 'ultimate health potion')

-- itens para vender
shopModule:addSellableItem({'flask'},                             7636,   10, 'flask')
shopModule:addSellableItem({'big flask'},                         7634,   15, 'big flask')
shopModule:addSellableItem({'large flask'},                       7635,   20, 'large flask')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "Voce pode {buy} ou {sell} potions aqui."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
