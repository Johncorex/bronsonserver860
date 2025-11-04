-- define itens iniciais por vocação - Leather Set + arma inicial + rope

local vocationFirstItems = {
	[0] =  {2461, 2467, 2649, 2643, 2512, 2190},    -- admin
    [1] =  {2461, 2467, 2649, 2643, 2512, 2190},    -- Sorcerer
    [2] =  {2461, 2467, 2649, 2643, 2512, 2182},    -- Druid 
    [3] =  {2461, 2467, 2649, 2643, 2512, 5907},    -- Paladin 
    [4] =  {2461, 2467, 2649, 2643, 2512, 8602},    -- Knight 
	[17] = {2461, 2467, 2649, 2643, 2512, 2439},    -- Miner 
	[21] = {2461, 2467, 2649, 2643, 2512, 5907},    -- Elf
	[25] = {2461, 2467, 2649, 2643, 2512, 8601},    -- Orc
}

function onLogin(player)
    if player:getLastLoginSaved() == 0 then
        -- obtém o ID da vocação
        local vocId = player:getVocation():getId()
        -- escolhe os itens da vocação, ou os default
        local firstItems = vocationFirstItems[vocId]

        -- dá cada item uma unidade
        for _, itemId in ipairs(firstItems) do
            player:addItem(itemId, 1)
        end

		-- cria a bag e armazena o objeto retornado
        local bag = player:addItem(ITEM_BAG, 1)
        if bag then
            -- adiciona runas, corda e shovel dentro da mesma bag
            bag:addItem(2120, 1)  -- rope
            bag:addItem(2789, 5)  -- brown mushroom
		else
            -- opcional: logar ou avisar erro de criação de bag
            print("Erro ao criar bag com food.")
        end

    end
    return true
end
