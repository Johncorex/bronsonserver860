-- esdras.lua

local keywordHandler = KeywordHandler:new()
local npcHandler     = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- Eventos básicos
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)    end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                npcHandler:onThink()                end

-- Vozes automáticas
local voices = {
  { text = "Varinhas, cetros e bastoes! (La ele...) Confira minhas ofertas!"  }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Módulo de shop
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Itens à venda (buyable)
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186,  800, 1, 'moonlight rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 1600, 1, 'necrotic rod')
shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182,   50, 1, 'snakebite rod')
shopModule:addBuyableItem({'terra rod', 'terra'},       2181, 3000, 1, 'terra rod')
shopModule:addBuyableItem({'cosmic wand', 'cosmic'},    2189, 3000, 1, 'wand of cosmic energy')
shopModule:addBuyableItem({'decay wand', 'decay'},      2188, 1600, 1, 'wand of decay')
shopModule:addBuyableItem({'dragonbreath', 'dragon'},   2191,  800, 1, 'wand of dragonbreath')
shopModule:addBuyableItem({'vortex', 'vortex wand'},    2190,   50, 1, 'wand of vortex')

-- Itens para vender ao NPC (sellable)
shopModule:addSellableItem({'aghanin scepter', 'aghanin'},     7424, 120000, 'Aghanims Scepter')
shopModule:addSellableItem({'arcane wand', 'arcane'},           2453,   4500, 'Arcane Wand')
shopModule:addSellableItem({'hailstorm rod', 'hailstorm'},      2183,   3000, 'Hailstorm Rod')
shopModule:addSellableItem({'mekansm', 'mekansm'},              7410, 150000, 'Mekansm')
shopModule:addSellableItem({'moonlight rod', 'moonlight'},      2186,    266, 'Moonlight Rod')
shopModule:addSellableItem({'motaba scepter', 'motaba'},           7379,    7000,'motaba scepter')
shopModule:addSellableItem({'necrotic rod', 'necrotic'},       2185,    533, 'Necrotic Rod')
shopModule:addSellableItem({'saruman scepter', 'saruman'},      7451,   16000,'Sarumans Scepter')
shopModule:addSellableItem({'saurons breath', 'sauron'},       8910,     500,'Saurons Breath')
shopModule:addSellableItem({'snakebite rod', 'snakebite'},     2182,     16, 'Snakebite Rod')
shopModule:addSellableItem({'terra rod', 'terra'},             2181,   1000, 'Terra Rod')
shopModule:addSellableItem({'cosmic wand', 'cosmic'},          2189,   1000, 'Wand of Cosmic Energy')
shopModule:addSellableItem({'decay wand', 'decay'},            2188,    533, 'Wand of Decay')
shopModule:addSellableItem({'dragonbreath', 'dragon'},         2191,    266, 'Wand of Dragonbreath')
shopModule:addSellableItem({'inferno wand', 'inferno'},        2187,   2000, 'Wand of Inferno')
shopModule:addSellableItem({'vortex', 'vortex wand'},          2190,     16, 'Wand of Vortex')

-- Comandos genericos
keywordHandler:addKeyword({'trade','shop','venda'}, StdModule.say, {
  npcHandler = npcHandler,
  text       = "De um olhar nas minhas ofertas: {buy} para comprar e {sell} para vender."
})
keywordHandler:addAliasKeyword({'wares','offer','stuff'})

-- Foco
npcHandler:addModule(FocusModule:new())
