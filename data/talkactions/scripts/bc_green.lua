function onSay(player, words, param)
	if not player:hasFlag(PlayerFlag_CanBroadcast) then
		return true
	end

	if param == "" then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Digite a mensagem.")
		return false
	end

	print("> Broadcasted: \"" .. param .. "\".")
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, param)
	end
	return false
end