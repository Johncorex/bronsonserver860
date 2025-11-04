local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()  npcHandler:onThink() end
function AddMount(cid, message, keywords, parameters, node) --by vodka
if(not npcHandler:isFocused(cid)) then
return false
end

if (getPlayerVocation(cid) >= 17 and getPlayerVocation(cid) <= 27 )then
npcHandler:say('Sua vocation nao pode adiquirir essa montaria', cid)
return false
end

local items = {
           item1 = {13301,30}, 
		   item2 = {13299,50}, 
		   item3 = {13300,100}
		   

}

if getPlayerPremiumDays(cid) >= 1  then
if(parameters.level ~= nil and getPlayerLevel(cid) < parameters.level) then
npcHandler:say('Voce precisa ser level ' .. parameters.level .. ' para adiquirir a montaria.', cid)
elseif getPlayerMount(cid, parameters.mountid) then
npcHandler:say('voce ja possui essa montaria', cid)
elseif not  doPlayerRemoveItem(cid, items.item1[1], items.item1[2]) then
npcHandler:say('Desculpe, voce precisa de 30 hollow stampor hoof, 50 stampor horn e 100 stampor talons.', cid)
elseif not  doPlayerRemoveItem(cid, items.item2[1], items.item2[2]) then
npcHandler:say('Desculpe, voce precisa de 30 hollow stampor hoof, 50 stampor horn e 100 stampor talons.', cid)
elseif not  doPlayerRemoveItem(cid, items.item3[1], items.item3[2]) then
npcHandler:say('Desculpe, voce precisa de 30 hollow stampor hoof, 50 stampor horn e 100 stampor talons.', cid)
else
doPlayerAddMount(cid, parameters.mountid)
npcHandler:say('Aqui esta sua montaria!', cid)
npcHandler:resetNpc()
end

else
npcHandler:say('Apenas jogadores vips podem adiquirir a montaria.', cid)
end
npcHandler:resetNpc()
return true
end




local mounts = {
{"stampor", items = {{13301,30},{13299,50}, {13300,100}}, mountid = 11, level = 10, premium = false},
}

for i = 1, #mounts do local get = mounts[i] if type(get.items) == "table" then
local node = keywordHandler:addKeyword({get[1]}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Voce deseja obter a montaria Stampor ?"})
node:addChildKeyword({"yes"}, AddMount, {items = get.items,mountid = get.mountid, level = get.level, premium = get.premium})
node:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "ok, sem problema !.", reset = true})
else keywordHandler:addKeyword({get[1]}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = get.text}) end end
mounts = nil npcHandler:addModule(FocusModule:new())