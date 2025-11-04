local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
    npcHandler:onThink()
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    local talkUser, msg, str, rst = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid, msg:lower(), "", ""
    local task, daily, hours = player:getTaskMission(), player:getDailyTaskMission(), 24

    if isInArray({"task", "tasks", "missao", "mission", "tarefa"}, msg) then
        if taskSystem[task] then
            if player:getStorageValue(taskSystem[task].start) <= 0 then
                if player:getLevel() >= taskSystem[task].level then
                    player:setStorageValue(taskSystem[task].start, 1)
                    npcHandler:say("[Task System] Parabens, voce esta participando na Task "..taskSystem[task].name.." e deve Matar "..taskSystem[task].count.." dessa lita: "..getMonsterFromList(taskSystem[task].monsters_list)..". "..(#taskSystem[task].items > 0 and "Ah, e porfavor traga "..getItemsFromList(taskSystem[task].items).." para mim." or "").."" , cid)
                else
                    npcHandler:say("Desculpe, voce ainda nao atingiu o nivel "..taskSystem[task].level.." para pode participar das tasks "..taskSystem[task].name.."!", cid)
                end
            else
                npcHandler:say("Desculpe, voce ja esta em uma task "..taskSystem[task].name..". Voce deve {receber} se ja terminou.", cid)
            end
        else
            npcHandler:say("Desculpe, mas por agora eu nao tenho mais tasks para voce!", cid)
        end
    elseif isInArray({"diaria", "daily", "dayli", "diario"}, msg) then
        if player:getStorageValue(taskSystem_storages[6]) - os.time() > 0 then
            npcHandler:say("Desculpe, voce precisa esperar ate "..os.date("%d %B %Y %X ", player:getStorageValue(taskSystem_storages[6])).." para iniciar mais uma task diaria!", cid)
            return true
		elseif player:getStorageValue(taskSystem_storages[7]) > 0 then
			npcHandler:say("Voce ja iniciou uma task diaria: "..(dailyTasks[daily] and dailyTasks[daily].name or "Desconhecida")..". Voce precisa terminar ou entregar ela primeiro.", cid)
			return true
		end
        local r = player:randomDailyTask()
        if r == 0 then
            npcHandler:say("Desculpe, Mas voce ainda nao tem level para completar nenhuma task diaria.", cid)
            return true
        end
        player:setStorageValue(taskSystem_storages[4], r)
        player:setStorageValue(taskSystem_storages[6], os.time() + hours * 3600)
        player:setStorageValue(taskSystem_storages[7], 1)
        player:setStorageValue(taskSystem_storages[5], 0)
        local dtask = dailyTasks[r]
        npcHandler:say("[Daily Task System] Parabens, voce agora esta participando da Task Diaria "..dtask.name.." e deve matar "..dtask.count.." criaturas dessa lista: "..getMonsterFromList(dtask.monsters_list).." ate as "..os.date("%d %B %Y %X ", player:getStorageValue(taskSystem_storages[6]))..". Bom sorte newba!" , cid)
    elseif isInArray({"receber", "reward", "recompensa", "report", "reportar", "entregar", "entrega"}, msg) then
        local v, k = taskSystem[task], dailyTasks[daily]
        if v then -- Original Task
            if player:getStorageValue(v.start) > 0 then
                if player:getStorageValue(taskSystem_storages[3]) >= v.count then
                    if #v.items > 0 and not doRemoveItemsFromList(cid, v.items) then
                        npcHandler:say("Desculpe, Mas voce tambem tem que entregar esses items:"..getItemsFromList(v.items), cid)
                        return true
                    end

                    if v.exp > 0 then
                        player:addExperience(v.exp)
                        str = str.." "..v.exp.." experiencia"
                    end
                    if v.points > 0 then
                        player:setStorageValue(taskSystem_storages[2], (player:getTaskPoints() + v.points))
                        str = str.." + "..v.points.." task points"
                    end
                    if v.money > 0 then
                        player:addMoney(v.money)
                        str = str.." "..v.money.." gold coins"
                    end
                    if table.maxn(v.reward) > 0 then
                        player:giveRewardsTask(v.reward)
                        str = str.." "..getItemsFromList(v.reward)
                    end
                    npcHandler:say("Obrigado pela sua ajuda! Recompensa: "..(str == "" and "nenhum" or str).." por completar a task de "..v.name, cid)
                    player:setStorageValue(taskSystem_storages[3], 0)
                    player:setStorageValue(taskSystem_storages[1], (task + 1))
                else
                    npcHandler:say("Desculpe, mas voce ainda nao terminou a sua task "..v.name.." ainda. Eu preciso que voce mate mais "..(player:getStorageValue(taskSystem_storages[3]) < 0 and v.count or -(player:getStorageValue(taskSystem_storages[3]) - v.count)).." dessas pestes!", cid)
                end
            else
            npcHandler:say("Me desculpe amigo, mas voce ja terminou a sua task diaria de hoje, e alias, voce nao pode pegar mais tasks hoje. Volte amanha, e iremos discutir mais sobre o assunto. Se voce tiver interesse, Eu posso te oferecer uma task comum. Apenas fale 'task' para expressar o seu interesse.", cid)
            end
        end

        if k then -- Daily Task
            if player:getStorageValue(taskSystem_storages[7]) > 0 then
                if player:getStorageValue(taskSystem_storages[5]) >= k.count then
                    if k.exp > 0 then
                        player:addExperience(k.exp)
                        rst = rst.." "..k.exp.." experience"
                    end
                    if k.points > 0 then
                        player:setStorageValue(taskSystem_storages[2], (player:getTaskPoints() + k.points))
                        rst = rst.." + "..k.points.." task points"
                    end
                    if k.money > 0 then
                        player:addMoney(k.money)
                        rst = rst.." "..k.money.." gold coins"
                    end
                    if table.maxn(k.reward) > 0 then
                        player:giveRewardsTask(k.reward)
                        rst = rst.." "..getItemsFromList(k.reward)
                    end
                    npcHandler:say("Obrigado pela sua ajuda! Recompensa: "..(rst == "" and "nenhum" or rst).." por completar a sua task diaria de "..k.name, cid)
                    player:setStorageValue(taskSystem_storages[4], 0)
                    player:setStorageValue(taskSystem_storages[5], 0)
                    player:setStorageValue(taskSystem_storages[7], 0)
                else
                    npcHandler:say("Desculpe, mas voce nao terminou a task "..k.name.." ainda. Preciso que voce mate mais "..(player:getStorageValue(taskSystem_storages[5]) < 0 and k.count or -(player:getStorageValue(taskSystem_storages[5]) - k.count)).." dessas pragas!", cid)
                end   
            end
        end
    elseif msg == "nao" then
        npcHandler:say("Okay entao.", cid)
        talkState[talkUser] = 0
        npcHandler:releaseFocus(cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())