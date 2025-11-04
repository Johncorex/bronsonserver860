-- Autoloot com deposito automatico de moedas no banco
-- Coins: gold(2148)=1 gp, platinum(2152)=100 gp, crystal(2160)=10000 gp
local COINS = {
    [2148] = 1,
    [2152] = 100,
    [2160] = 10000,
}

-- Opcional: mostrar mensagem quando depositar
local SHOW_DEPOSIT_MSG = true

local function sweepContainer(player, container)
    if not container or not container:isContainer() then
        return 0
    end

    -- Copia itens pra lista temporaria (evita problemas ao remover/mover)
    local items = {}
    for i = 0, container:getSize() - 1 do
        local it = container:getItem(i)
        if it then
            table.insert(items, it)
        end
    end

    local deposited = 0

    for _, it in ipairs(items) do
        if it:isContainer() then
            -- Recursivo em sub-containers
            deposited = deposited + sweepContainer(player, Container(it.uid))
        else
            local id = it:getId()
            local worth = COINS[id]

            if worth then
                -- Somar valor e remover a pilha de moedas
                local count = it:getCount()
                deposited = deposited + (worth * count)
                it:remove()
            else
                -- Autoloot normal para outros itens (usa suas storages)
                for i = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
                    if player:getStorageValue(i) == id then
                        it:moveTo(player)
                        break
                    end
                end
            end
        end
    end

    return deposited
end

local function scanCorpseAndLoot(cid, pos)
    local player = Player(cid)
    if not player then return end

    local topItem = Tile(pos):getTopDownItem()
    if not topItem or not topItem:getType():isCorpse() then return end

    -- Garante que o corpse e do player
    if topItem:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) ~= cid then return end

    local container = Container(topItem.uid)
    if not container then return end

    -- Varre corpse e sub-bags: deposita moedas e ainda move os itens do autoloot
    local gp = sweepContainer(player, container)
    if gp > 0 then
        -- Creditar no banco do jogador (TFS 1.x)
        player:setBankBalance(player:getBankBalance() + gp)
        if SHOW_DEPOSIT_MSG then
            player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Deposited %d gold directly into your bank.", gp))
        end
    end
end

function onKill(player, target)
    if not target:isMonster() then
        return true
    end
    -- Pequeno delay pro loot aparecer
    addEvent(scanCorpseAndLoot, 100, player:getId(), target:getPosition())
    return true
end
