local vocationOutfits = {
    -- [vocationId] = {maleOutfitId, femaleOutfitId}
    [1] = {128, 136},  -- Sorcerer/Sorceress
    [2] = {129, 137},  -- Druid/Druidess
    [3] = {130, 138},  -- Paladin/Paladiness
    [4] = {131, 139},  -- Knight/Knightess
	[17] = {143, 147}, -- miner 
    -- Adicione outras vocações se necessário
}

function onLogin(player)
    local vocationId = player:getVocation():getId()
    local sex = player:getSex()
    local outfitId = vocationOutfits[vocationId] and vocationOutfits[vocationId][sex == PLAYERSEX_FEMALE and 2 or 1]
    
    if outfitId then
        -- Desbloqueia o outfit
        player:addOutfit(outfitId)
        player:addOutfitAddon(outfitId, 3)  -- Todas addons
        
        -- Aplica o outfit
        player:setOutfit({
            lookType = outfitId,
            lookHead = 78,   -- Cor personalizável
            lookBody = 106,  -- Cor personalizável
            lookLegs = 116,  -- Cor personalizável
            lookFeet = 95    -- Cor personalizável
        })
    end
    return true
end