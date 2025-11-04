function onSay(cid, words, param)
    local player = Player(cid)
    if not player then
        return false
    end

    local balance = player:getBankBalance()
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Your account balance is " .. balance .. " gold coins.")
    return false
end
