-- shop_backpacks.lua

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
  { text = "Backpacks for sale! Check my stock!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens para comprar
shopModule:addBuyableItem({'backpack marrom','brown backpack'}, 1988, 20, 1, 'backpack marrom')
shopModule:addBuyableItem({'backpack roxa','purple backpack'}, 2001, 20, 1, 'backpack roxa')
shopModule:addBuyableItem({'backpack azul','blue backpack'},   2002, 20, 1, 'backpack azul')
shopModule:addBuyableItem({'backpack amarela','yellow backpack'},2004,20, 1, 'backpack amarela')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','buy'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "You can {buy} backpacks here."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
