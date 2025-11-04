function onLogin(player)
    local serverName = configManager.getString(configKeys.SERVER_NAME)
    local loginStr = "Bem vindo ao " .. serverName .. "! Acesse o nosso dioscord e fique por dentro das atualizacoes: https://discord.gg/aNGkrqEHjv"
	-- Definindo a tabela compartilhada separadamente
	local sharedOutfitsTable = {
		[0] = { -- Feminino
			{lookType = 136, addons = 0}, -- Citizen
			{lookType = 137, addons = 0}, -- Hunter
			{lookType = 138, addons = 0}, -- Mage
			{lookType = 139, addons = 0}, -- Knight
			{lookType = 140, addons = 0}, -- Noblewoman
			{lookType = 141, addons = 0}, -- Summoner
			{lookType = 142, addons = 0}, -- Warrior
			{lookType = 147, addons = 0}, -- Barbarian
			{lookType = 148, addons = 0}, -- Druid
			{lookType = 149, addons = 0}, -- Wizard
			{lookType = 150, addons = 0}, -- Oriental
			{lookType = 155, addons = 0}, -- Pirate
			--{lookType = 156, addons = 0}, -- Assassin
			{lookType = 157, addons = 0}, -- Beggar
			{lookType = 158, addons = 0}, -- Shaman
			--{lookType = 252, addons = 0}, -- Norsewoman
			--{lookType = 269, addons = 0}, -- Nightmare
			--{lookType = 270, addons = 0}, -- Jester
			--{lookType = 279, addons = 0}, -- Brotherhood
			--{lookType = 288, addons = 0}, -- Demon Hunter
			--{lookType = 324, addons = 0}, -- Yalaharian
			--{lookType = 329, addons = 0}, -- Newly Wed
			--{lookType = 336, addons = 0}, -- Warmaster
			--{lookType = 366, addons = 0}  -- Wayfarer
		},
		
		[1] = { -- Masculino
			{lookType = 128, addons = 0}, -- Citizen
			{lookType = 129, addons = 0}, -- Hunter
			{lookType = 130, addons = 0}, -- Mage
			{lookType = 131, addons = 0}, -- Knight
			{lookType = 132, addons = 0}, -- Nobleman
			{lookType = 133, addons = 0}, -- Summoner
			{lookType = 134, addons = 0}, -- Warrior
			{lookType = 143, addons = 0}, -- Barbarian
			{lookType = 144, addons = 0}, -- Druid
			{lookType = 145, addons = 0}, -- Wizard
			{lookType = 146, addons = 0}, -- Oriental
			{lookType = 151, addons = 0}, -- Pirate
			--{lookType = 152, addons = 0}, -- Assassin
			{lookType = 153, addons = 0}, -- Beggar
			{lookType = 154, addons = 0}, -- Shaman
			--{lookType = 251, addons = 0}, -- Norseman
			--{lookType = 268, addons = 0}, -- Nightmare
			--{lookType = 273, addons = 0}, -- Jester
			--{lookType = 278, addons = 0}, -- Brotherhood
			--{lookType = 289, addons = 0}, -- Demon Hunter
			--{lookType = 325, addons = 0}, -- Yalaharian
			--{lookType = 328, addons = 0}, -- Newly Wed
			--{lookType = 335, addons = 0}, -- Warmaster
			--{lookType = 367, addons = 0}  -- Wayfarer
		}
	}

	
    local vocationOutfits = {
        -- Outfits compartilhados entre vocações 25, 1 e 2
		[0] = sharedOutfitsTable,
		[1] = sharedOutfitsTable,
		[2] = sharedOutfitsTable,
		[3] = sharedOutfitsTable,
		[4] = sharedOutfitsTable,
		[17] = sharedOutfitsTable,
			
		[21] = { -- ELF
            [0] = { -- Feminino
                {lookType =  62, addons = 3}, -- Elf
                --{lookType =  63, addons = 3}, -- Arcanist
                {lookType =  64, addons = 3}, -- Elf Scout
                {lookType = 159, addons = 3}  -- Elf Citizen
            },
            [1] = { -- Masculino
                {lookType =  62, addons = 3}, -- Elf
                --{lookType =  63, addons = 3}, -- Arcanist
                {lookType =  64, addons = 3}, -- Elf Scout
                {lookType = 159, addons = 3}  -- Elf Citizen
            }
        },
        [25] = { -- ORC
            [0] = { -- Feminino
                {lookType =  5, addons = 3}, -- Orc
                {lookType = 50, addons = 3}, -- Orc Spearman
                {lookType =  7, addons = 3}, -- Orc Warrior
                {lookType =  6, addons = 3}, -- Orc Shaman
                {lookType =  8, addons = 3}, -- Orc Berserker
                {lookType = 59, addons = 3}, -- Orc Leader
                --{lookType =  2, addons = 3}  -- Orc Warlord
            },
            [1] = { -- Masculino
                {lookType =  5, addons = 3}, -- Orc
                {lookType = 50, addons = 3}, -- Orc Spearman
                {lookType =  7, addons = 3}, -- Orc Warrior
                {lookType =  6, addons = 3}, -- Orc Shaman
                {lookType =  8, addons = 3}, -- Orc Berserker
                {lookType = 59, addons = 3}, -- Orc Leader
                --{lookType =  2, addons = 3}  -- Orc Warlord
            }
        }
    }
    
    if player:getLastLoginSaved() <= 0 then
        local vocationId = player:getVocation():getId()
        local sex = player:getSex()
        local possibleOutfits = vocationOutfits[vocationId] and vocationOutfits[vocationId][sex]

        if possibleOutfits and #possibleOutfits > 0 then
            -- Adiciona TODOS os outfits para o jogador
            for _, outfit in ipairs(possibleOutfits) do
                player:addOutfit(outfit.lookType)
                player:addOutfitAddon(outfit.lookType, outfit.addons or 0) -- Usa 0 se addons não estiver definido
            end
            
            -- Aplica o PRIMEIRO outfit da lista
            local firstOutfit = possibleOutfits[1]
            player:setOutfit({
                lookType = firstOutfit.lookType,
                lookHead = firstOutfit.colors and firstOutfit.colors.head or 78,   -- Valor padrão se não definido
                lookBody = firstOutfit.colors and firstOutfit.colors.body or 106,  -- Valor padrão
                lookLegs = firstOutfit.colors and firstOutfit.colors.legs or 116,  -- Valor padrão
                lookFeet = firstOutfit.colors and firstOutfit.colors.feet or 95    -- Valor padrão
            })
        end
        
        loginStr = loginStr .. " Choose your outfit colors."
        player:sendOutfitWindow()
    else
        if loginStr ~= "" then
            player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
        end


        loginStr = string.format("Your last visit in %s: %s.", serverName, os.date("%d %b %Y %X", player:getLastLoginSaved()))
    end
    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

    -- Promotion
    local vocation = player:getVocation()
    local promotion = vocation:getPromotion()
    if player:isPremium() then
        local value = player:getStorageValue(PlayerStorageKeys.promotion)
        if value == 1 then
            player:setVocation(promotion)
        end
    elseif not promotion then
        player:setVocation(vocation:getDemotion())
    end
	
	-- flask
    if player:getStorageValue(FLASK_REMOVER_STORAGE) >= 1 then
        removePlayerVials(player:getId())
    end

	-- Activate Custom Item Attributes
	for i = 1,10 do -- CONST_SLOT_FIRST,CONST_SLOT_LAST
		local item = player:getSlotItem(i)
		if item then
			itemAttributes(player, item, i, true)
		end
	end
	-- If player logged with more 'current health' than their db 'max health' due to an item attribute
	local query = db.storeQuery("SELECT `health`,`mana` FROM players where `id`="..player:getGuid())
	if query then
		local health = tonumber(result.getDataString(query, 'health'))
		local mana = tonumber(result.getDataString(query, 'mana'))
		local playerHealth = player:getHealth()
		local playerMana = player:getMana()
		if playerHealth < health then
			player:addHealth(health - playerHealth)
		end
		if playerMana < mana then
			player:addMana(mana - playerMana)
		end
		result.free(query)
	end

    -- Events
    player:registerEvent("PlayerDeath")
    player:registerEvent("DropLoot")
	player:registerEvent("AutoLoot")
	player:registerEvent("rollHealth")
	player:registerEvent("rollMana")
    return true
end