local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)    end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                npcHandler:onThink()                end
-- OTServ event handling functions end

--[[
  travelNodes:
  chave = nome da rota (minusculo)
  cost = preco em gp
  dest = Position(x,y,z)
  msg  = texto exibido ao perguntar
--]]
local travelNodes = {
  edoras     = { cost = 85,  dest = Position(1037,  984, 7), msg = "Voce quer ir para Edoras por %dgp?" },
  belfallas  = { cost = 60,  dest = Position(1168, 1527, 6), msg = "Voce quer ir para Belfallas por %dgp?" },
  eriador    = { cost = 30,  dest = Position( 826,  723, 7), msg = "Voce quer ir para Eriador por %dgp?" },
  mordor     = { cost = 100, dest = Position(1436, 1278, 7), msg = "Voce quer ir para Mordor por %dgp?" },
  dunedain   = { cost = 100, dest = Position(1558,  458, 7), msg = "Voce quer ir para Dunedain por %dgp?" },
  lorien     = { cost = 50,  dest = Position(1067,  860, 7), msg = "Voce quer ir para Lorien por %dgp?" },
  rivendell  = { cost = 80,  dest = Position(1146,  580, 7), msg = "Voce quer ir para Rivendell por %dgp?" },
  dolguldur  = { cost = 55,  dest = Position(1162,  747, 7), msg = "Voce quer ir para DolGuldur por %dgp?" },
  grey       = { cost = 100, dest = Position(1093,  339, 7), msg = "Voce quer ir para Grey Mountains por %dgp?" },
  pirata     = { cost = 100, dest = Position( 580, 1157, 7), msg = "Voce quer ir para a ilha Pirata por %dgp?" },
  pantano    = { cost = 25,  dest = Position(1250, 1075, 7), msg = "Voce quer ir para o Pantano por %dgp?" },
  argond     = { cost = 85,  dest = Position( 645,  923, 7), msg = "Voce quer ir para Argond por %dgp?" },
  rhun       = { cost = 100, dest = Position(1758,  813, 7), msg = "Voce quer ir para Rhun por %dgp?" },
  ashenport  = { cost = 100, dest = Position(334,   606, 6), msg = "Voce quer ir para Ashenport por %dgp?" },
  forochel   = { cost = 100, dest = Position(507,   116, 6), msg = "Voce quer ir para Forechel por %dgp?" },
  forodwaith = { cost = 100, dest = Position(644,   108, 6), msg = "Voce quer ir para Rhun por %dgp?" },
}

-- gera lista de nomes e resumo
local allNames = {}
for name in pairs(travelNodes) do table.insert(allNames, name) end
table.sort(allNames)
local summary = "Posso te levar para " .. table.concat(allNames, ", ") .. " por uma pequena taxa."

-- mensagem de cumprimento ao falar hi
npcHandler:setMessage(MESSAGE_GREET, "Bem vindo, |PLAYERNAME|. " .. summary)

-- cria palavras-chave dinamicamente
for name, data in pairs(travelNodes) do
  local text = string.format(data.msg, data.cost)
  local node = keywordHandler:addKeyword({name}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus  = true,
    text       = text
  })
  node:addChildKeyword({'yes'}, StdModule.travel, {
    npcHandler = npcHandler,
    premium     = false,
    level       = 0,
    cost        = data.cost,
    destination = data.dest
  })
  node:addChildKeyword({'no'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus  = true,
    reset      = true,
    text       = "Tudo bem, talvez outra hora."
  })
end

-- opcao de resumo por comando
keywordHandler:addKeyword({'viajar','travel','ir'}, StdModule.say, {
  npcHandler = npcHandler,
  onlyFocus  = true,
  text       = summary
})

npcHandler:addModule(FocusModule:new())
