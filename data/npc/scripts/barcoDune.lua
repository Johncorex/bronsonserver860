
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end
-- OTServ event handling functions end

local travelNode = {}

-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!
travelNode = keywordHandler:addKeyword({'pantano'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para o Pantano por 25?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 25, destination = Position (1250, 1075, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'belfallas'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Belfallas por 90?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 90, destination = Position (1179, 1516, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'eriador'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Eriador por 70?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 70, destination = Position (826, 723, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'argond'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Argond por 85?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 85, destination = Position (645, 923, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'rivendell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Rivendell por 80?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 80, destination = Position (1146, 580, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelKeyword = keywordHandler:addKeyword({'dolguldur'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Dol\'Guldur por 55?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 55, destination = Position (1162, 747, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'grey'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Grey Mountains por 100?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 100, destination = Position (1093, 339, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelKeyword = keywordHandler:addKeyword({'lorien'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para o Lorien por 50?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 50, destination = Position (1067, 860, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelKeyword = keywordHandler:addKeyword({'pirata'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para a ilha pirata por 100?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 100, destination = Position (580, 1157, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'mordor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para mordor por 100?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 100, destination = Position (1436, 1278, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelKeyword = keywordHandler:addKeyword({'edoras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Edoras por 85 gp?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 85, destination = Position (1037, 984, 7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?.'})
	
travelKeyword = keywordHandler:addKeyword({'travel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te levar para Edoras, Pantano, Dol\'Guldur, Lorien, Rivendell, Grey Mountains, Belfallas, Eriador, Mordor e Argond por uma pequena taxa.'})
travelKeyword = keywordHandler:addKeyword({'ir'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te levar para Edoras, Pantano, Dol\'Guldur, Lorien, Rivendell, Grey Mountains, Belfallas, Eriador, Mordor e Argond por uma pequena taxa.'})
travelKeyword = keywordHandler:addKeyword({'viajar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te levar para Edoras, Pantano, Dol\'Guldur, Lorien, Rivendell, Grey Mountains, Belfallas, Eriador, Mordor e Argond por uma pequena taxa.'})



-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())
