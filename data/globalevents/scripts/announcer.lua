-- announcer.lua - mensagens aleatorias no broadcast

-- CONFIGURACAO
local ANNOUNCER = {
    -- tipo de mensagem (tenta usar o melhor disponivel)
    messageType = _G.MESSAGE_GAME_HIGHLIGHT or _G.MESSAGE_STATUS_WARNING or _G.MESSAGE_INFO_DESCR,

    -- prefixo opcional
    prefix = "",

    -- evita repetir a mesma mensagem consecutiva
    avoidRepeat = true,

    -- lista de mensagens (edite a vontade)
    messages = {
        "Voce pode conferir os drops das criaturas no nosso site: https://www.bronsonproject.com/monsters",
        "Discord: https://discord.gg/aNGkrqEHjv",
		"Reporte bugs no nosso discord: !discord",
		"Ajude o servidor, seja Vip! Vantagens Vip: https://www.bronsonproject.com/vip",
		"Voce pode usar o comando /ir para checkar todas as localidades disponiveis "
    }
}

-- estado interno
local lastIndex = -1

local function pickIndex()
    local n = #ANNOUNCER.messages
    if n == 0 then return nil end
    if not ANNOUNCER.avoidRepeat or n == 1 then
        return math.random(1, n)
    end
    local i
    repeat
        i = math.random(1, n)
    until i ~= lastIndex
    lastIndex = i
    return i
end

function onThink(interval)
    local idx = pickIndex()
    if not idx then
        return true
    end

    local text = (ANNOUNCER.prefix or "") .. ANNOUNCER.messages[idx]
    Game.broadcastMessage(text, ANNOUNCER.messageType)
    return true
end
