-- Tiles de verificação dos tronos de PoI
-- Se faltar um storage, jogador é repelido e recebe mensagem

local REPEL_POS = Position(1396, 577, 12)

-- Mapeamento de qual AID verifica qual storage
local config = {
    [25701] = {storage = 25690, name = "Infernatil"},
    [25702] = {storage = 25691, name = "Tafariel"},
    [25703] = {storage = 25692, name = "Verminor"},
    [25704] = {storage = 25693, name = "Apocalypse"},
    [25705] = {storage = 25694, name = "Bazir"},   
    [25706] = {storage = 25695, name = "Ashfalor"},
    [25707] = {storage = 25696, name = "Pumin"},
}

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local conf = config[item.actionid]
    if not conf then
        return true
    end

    -- verifica se o player tem o storage do trono
    if player:getStorageValue(conf.storage) ~= 1 then
        player:teleportTo(REPEL_POS)
        REPEL_POS:sendMagicEffect(CONST_ME_TELEPORT)
        player:say("Voce nao passou pelo trono de "..conf.name..".", TALKTYPE_MONSTER_SAY)
    end
    return true
end
