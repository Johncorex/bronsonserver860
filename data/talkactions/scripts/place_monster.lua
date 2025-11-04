-- place_monster.lua
-- Permite GMs (groupId ≥ 6) colocarem um monstro no local do jogador via comando de talkaction

-- Função auxiliar para trim (remove espaços em branco nas extremidades)
local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function onSay(player, words, param)
    -- Checagem de permissão (GOD = groupId 6)
    if player:getGroup():getId() < 6 then
        player:sendCancelMessage("Voce precisa de permissao GOD para usar este comando.")
        return false
    end

    -- Validação de parâmetro: deve ser o nome do monstro
    if not param or trim(param) == "" then
        player:sendCancelMessage("Uso: " .. words .. " <nomeDoMonstro>")
        return false
    end

    local monsterName = trim(param)
    local position    = player:getPosition()
    local monster     = Game.createMonster(monsterName, position)

    if not monster then
        player:sendCancelMessage("Nao foi possível spawnar '" .. monsterName .. "' aqui.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- Efeitos visuais de confirmação
    position:sendMagicEffect(CONST_ME_TELEPORT)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "'" .. monsterName .. "' spawnado com sucesso!")
    return false
end
