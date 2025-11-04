local availableCommands = {
    {words = "/ir", description = "Teleporte para varias localidades", access = 0},
	{words = "!balance", description = "Check your bank balance", access = 0},
	{words = "!bless", description = "Check Blesses", access = 0},
    {words = "!spells", description = "Spells disponiveis", access = 0},
    {words = "!autoloot", description = "Manage autoloot list", access = 0},
    {words = "!flask", description = "Enable flask remover", access = 0},
	
	{words = "!buyhouse", description = "Compra a casa a sua frente", access = 0},
	{words = "!sellhouse", description = "Vende a casa para outro jogador", access = 0},
	{words = "!leavehouse", description = "Sai da casa", access = 0},
	
	{words = "!kills", description = "Checka seus frags", access = 0},
	{words = "!deathlist", description = "Checka a lista de morte de algum jogador", access = 0},
	
	{words = "!serverinfo", description = "Checka as infos do servidor", access = 0},
	{words = "!uptime", description = "Checka o tempo online do servidor", access = 0},
	{words = "!discord", description = "Link para o discord do servidor", access = 0},
    
	{words = "!commands", description = "Show available commands", access = 0}
	
	
  --{words = "/clean", description = "Clean the map", access = 3},
  --{words = "/reload", description = "Reload server files", access = 5},
  --{words = "/ghost", description = "Enter ghost mode", access = 5},
  --{words = "/kick", description = "Kick a player", access = 4},
  --{words = "/ban", description = "Ban a player", access = 6}
}

function onSay(cid, words, param)
    local player = Player(cid)
    if not player then return false end

    local access = getPlayerAccess(cid)
    local text = {"Available Commands:\n"}

    for _, cmd in ipairs(availableCommands) do
        if access >= cmd.access then
            text[#text + 1] = string.format(" %s - %s\n", cmd.words, cmd.description)
        end
    end

    player:showTextDialog(1950, table.concat(text))
    return true
end
