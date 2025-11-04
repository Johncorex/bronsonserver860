-- shop_jewelry.lua

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
  { text = "Eu compro joias! Mostre seus itens!" }
}
npcHandler:addModule(VoiceModule:new(voices))

-- modulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- itens que o NPC compra (sellable to NPC)
shopModule:addSellableItem({'elven brooch'},     2122,  200, 'elven brooch')
shopModule:addSellableItem({'crystal ring'},     2124,  250, 'crystal ring')
shopModule:addSellableItem({'emerald bangle'},   2127,  350, 'emerald bangle')
shopModule:addSellableItem({'crown'},            2128,  600, 'crown')
shopModule:addSellableItem({'silver brooch'},    2134,  180, 'silver brooch')
shopModule:addSellableItem({'black pearl'},      2144,  150, 'black pearl')
shopModule:addSellableItem({'white pearl'},      2143,  100, 'white pearl')
shopModule:addSellableItem({'silver amulet'},    2170,  120, 'silver amulet')
shopModule:addSellableItem({'bronze amulet'},    2172,   75, 'bronze amulet')
shopModule:addSellableItem({'gold ring'},        2179,  450, 'gold ring')
shopModule:addSellableItem({'small emerald'},    2149,  220, 'small emerald')
shopModule:addSellableItem({'small amethyst'},   2150,  240, 'small amethyst')
shopModule:addSellableItem({'small sapphire'},   2146,  180, 'small sapphire')
shopModule:addSellableItem({'small ruby'},       2147,  260, 'small ruby')
shopModule:addSellableItem({'small diamond'},    2145,  300, 'small diamond')
shopModule:addSellableItem({'gold ingot'},       9971, 8000, 'gold ingot')

-- comandos genericos
keywordHandler:addKeyword({'trade','shop','sell'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "Voce pode {sell} joias aqui."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- foco
npcHandler:addModule(FocusModule:new())
