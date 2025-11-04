local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)    npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                        npcHandler:onThink()                        end

local function greetCallback(cid)
    local player = Player(cid)
    local msg = 'Bem Vindo, ' .. player:getName() .. '.'
   
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local playerSpouse = getPlayerSpouse(player:getGuid())
    if (playerStatus == MARRIED_STATUS) then
        msg = msg .. ' Vejo que Voce e casado com ' .. ((player:getSex() == PLAYERSEX_FEMALE) and 'uma mulher' or 'um homem') .. '. O que traz Voce aqui? Procurando um {divorcio}?'
    elseif (playerStatus == PROPOSED_STATUS) then
        msg = msg .. ' Voce ainda está à espera para a proposta de casamento que Voce fez para {' .. (getPlayerNameById(playerSpouse)) .. '}. Voce gostaria de {remover} isso?'
    else
        msg = msg .. ' O que traz Voce aqui? Querendo {casar} com alguem?'
    end
    npcHandler:say(msg,cid)
    npcHandler:addFocus(cid)
    return false
end

local function tryEngage(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
   
    local player = Player(cid)
   
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local playerSpouse = getPlayerSpouse(player:getGuid())
    if playerStatus == MARRIED_STATUS then
        npcHandler:say('Voce ja está casado(a) com {' .. getPlayerNameById(playerSpouse) .. '}.', cid)
    elseif playerStatus == PROPOSED_STATUS then
        npcHandler:say('Voce ja fez uma proposta de casamento para {' .. getPlayerNameById(playerSpouse) .. '}. Voce sempre pode remover a proposta, dizendo {remover} proposta.', cid)
    else
        local candidate = getPlayerGUIDByName(message)
        if candidate == 0 then
            npcHandler:say('Um personagem com esse nome nao existe.', cid)
        elseif candidate == player:getGuid() then
            npcHandler:say('Voce nao pode casar com Voce mesmo.', cid)
        else
            if player:getItemCount(ITEM_WEDDING_RING) == 0 then
                npcHandler:say('Como eu disse, Voce precisa de um anel de casamento para se casar. Eu posso te vender bastar dizer {trade}', cid)
            else
                local candidateStatus = getPlayerMarriageStatus(candidate)
                local candidateSpouse = getPlayerSpouse(candidate)
                if candidateStatus == MARRIED_STATUS then
                    npcHandler:say('{' .. getPlayerNameById(candidate) .. '} ja está casado(a) com {' .. getPlayerNameById(candidateSpouse) .. '}.', cid)
                elseif candidateStatus == PROPOSED_STATUS then
                    if candidateSpouse == player:getGuid() then
                        npcHandler:say('Uma vez que ambos almas jovens estão dispostos a se casar, eu vos declaro {' .. getPlayerNameById(candidate) .. '} casados. {' .. player:getName() .. '}, tome esses dois aneis de casamento gravados e dê um deles para o seu cônjuge.', cid)
                        player:removeItem(ITEM_WEDDING_RING,1)
                        local item1 = Item(doPlayerAddItem(cid,ITEM_ENGRAVED_WEDDING_RING,1))
                        local item2 = Item(doPlayerAddItem(cid,ITEM_ENGRAVED_WEDDING_RING,1))
                        item1:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:getName() .. ' & ' .. getPlayerNameById(candidate) .. ' para sempre - casados em ' .. os.date('%B %d, %Y.'))
                        item2:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:getName() .. ' & ' .. getPlayerNameById(candidate) .. ' para sempre - casados em ' .. os.date('%B %d, %Y.'))
                        setPlayerMarriageStatus(player:getGuid(), MARRIED_STATUS)
                        setPlayerMarriageStatus(candidate, MARRIED_STATUS)
                        setPlayerSpouse(player:getGuid(), candidate)
                    else
                        npcHandler:say('{' .. getPlayerNameById(candidate) .. '} ja fez uma proposta de casamento para {' .. getPlayerNameById(candidateSpouse) .. '}.', cid)
                    end
                else
                    npcHandler:say('Ok, agora vamos esperar e ver se {' ..  getPlayerNameById(candidate) .. '} aceita sua proposta. Eu vou lhe dar seu anel de casamento o mais rápido possivel assim que {' ..  getPlayerNameById(candidate) .. '} aceitar sua proposta ou Voce {remover} essa ideia da cabeça.', cid)
                    player:removeItem(ITEM_WEDDING_RING,1)
                    setPlayerMarriageStatus(player:getGuid(), PROPOSED_STATUS)
                    setPlayerSpouse(player:getGuid(), candidate)
                end
            end
        end
    end
    keywordHandler:moveUp(3)
    return true
end

local function confirmRemoveEngage(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
   
    local player = Player(cid)
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local playerSpouse = getPlayerSpouse(player:getGuid())
    if playerStatus == PROPOSED_STATUS then
        npcHandler:say('Tem certeza de que deseja remover a sua proposta de casamento com {' .. getPlayerNameById(playerSpouse) .. '}?', cid)
        node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 3, text = 'Ok, vamos mantê-lo em seguida.'})
       
        local function removeEngage(cid, message, keywords, parameters, node)
            doPlayerAddItem(cid,ITEM_WEDDING_RING,1)
            setPlayerMarriageStatus(player:getGuid(), 0)
            setPlayerSpouse(player:getGuid(), -1)
            npcHandler:say(parameters.text, cid)
            keywordHandler:moveUp(parameters.moveup)
        end
        node:addChildKeyword({'yes'}, removeEngage, {moveup = 3, text = 'Ok, a sua proposta de casamento com {' .. getPlayerNameById(playerSpouse) .. '} foi removido. Leve o seu anel de casamento com Voce.'})
    else
        npcHandler:say('Voce nao tem propostas de casamento para remover.', cid)
        keywordHandler:moveUp(2)
    end
    return true
end

local function confirmDivorce(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
   
    local player = Player(cid)
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local playerSpouse = getPlayerSpouse(player:getGuid())
    if playerStatus == MARRIED_STATUS then
        npcHandler:say('Tem certeza de que quer se divorciar de {' .. getPlayerNameById(playerSpouse) .. '}?', cid)
        node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 3, text = 'Ótimo! Casamentos deve ser um compromisso eterno.'})
       
        local function divorce(cid, message, keywords, parameters, node)
            local player = Player(cid)
            local spouse = getPlayerSpouse(player:getGuid())
            setPlayerMarriageStatus(player:getGuid(), 0)
            setPlayerSpouse(player:getGuid(), -1)
            setPlayerMarriageStatus(spouse, 0)
            setPlayerSpouse(spouse, -1)
            npcHandler:say(parameters.text, cid)
            keywordHandler:moveUp(parameters.moveup)
        end
        node:addChildKeyword({'yes'}, divorce, {moveup = 3, text = 'Ok, agora Voce está divorciado(a) de {' .. getPlayerNameById(playerSpouse) .. '}. Pense melhor da próxima vez após se casar com alguem.'})
    else
        npcHandler:say('Voce nao e casado para se divorciar.', cid)
        keywordHandler:moveUp(2)
    end
    return true
end

local node1 = keywordHandler:addKeyword({'casar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce gostaria de se casar ? Certifique-se de que Voce tem um anel de casamento com Voce. Eu posso te vender esse anel.'})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 1, text = 'Isso e otimo.'})
local node2 = node1:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'E com quem gostaria de se casar ?'})
node2:addChildKeyword({'[%w]'}, tryEngage, {})

keywordHandler:addKeyword({'remover'}, confirmRemoveEngage, {})

keywordHandler:addKeyword({'divorcio'}, confirmDivorce, {})

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:addModule(FocusModule:new())