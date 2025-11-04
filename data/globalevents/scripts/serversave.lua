local shutdown = false
local clean = false
local closeServer = false
local minutes = 2 -- Min 1 minute
local notify = true

local function ServerSave()
    saveServer()
    Game.broadcastMessage("Server foi salvo com sucesso.", MESSAGE_STATUS_WARNING) -- <- mensagem após salvar

    if shutdown then
        Game.setGameState(GAME_STATE_SHUTDOWN)
    else
        if clean then
            cleanMap()
        end
        if closeServer then
            Game.setGameState(GAME_STATE_CLOSED)
        end
    end
end

local function ServerSaveWarning(time)
    local remaningTime = tonumber(time) - 60000
    if notify then
        local remainingNotifier = (remaningTime / 60000) > 1 and (remaningTime / 60000) or 1
        Game.broadcastMessage("Server vai salvar em " .. remainingNotifier .. " minuto(s). Fiquem safe.", MESSAGE_STATUS_WARNING)
    end

    if remaningTime > 60000 then
        addEvent(ServerSaveWarning, 60000, remaningTime)
    else
        addEvent(ServerSave, 60000)
    end
end

function onTime(interval)
    if notify then
        Game.broadcastMessage("Server vai salvar em " .. (minutes) .. " minuto(s). Fiquem safe.", MESSAGE_STATUS_WARNING)
    end
    addEvent(ServerSaveWarning, 60000, minutes * 60000)
    return not shutdown
end
