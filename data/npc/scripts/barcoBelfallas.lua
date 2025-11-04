
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
travelKeyword = keywordHandler:addKeyword({'lorien'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para o Lorien por 50?'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 50, destination = Position (1067,860,7) })
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelNode = keywordHandler:addKeyword({'rivendell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Rivendell por 80?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 80, destination = Position (1146,580,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelNode = keywordHandler:addKeyword({'dolguldur'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Dol\'Guldur por 55?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 55, destination = Position (1162,747,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelNode = keywordHandler:addKeyword({'grey'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Grey Mountains por 100?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 100, destination = Position (1093,339,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})

travelNode = keywordHandler:addKeyword({'edoras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para Edoras por 85 gp?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 85, destination = Position (1037,984,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?.'})
	
travelNode = keywordHandler:addKeyword({'pirata'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para a ilha pirata por 100?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 100, destination = Position (580,1157,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelNode = keywordHandler:addKeyword({'mordor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para mordor por 130?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 100, destination = Position (1436,1278,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelNode = keywordHandler:addKeyword({'dunedain'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce quer ir para dunedain por 150?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 150, destination = Position (1558,458,7) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Tá caro demais pra Voce?'})
	
travelNode = keywordHandler:addKeyword({'travel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te levar para Dol\'Guldur, Lorien, Rivendell, Grey Mountains, Dunedain, Mordor por uma pequena taxa.'})
travelNode = keywordHandler:addKeyword({'ir'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te levar para Dol\'Guldur, Lorien, Rivendell, Grey Mountains, Pirata, Dunedain, Mordor por uma pequena taxa.'})
travelNode = keywordHandler:addKeyword({'viajar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te levar para Dol\'Guldur, Lorien, Rivendell, Grey Mountains, Dunedain, Mordor por uma pequena taxa.'})

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())

