taskSystem = {
    [1] = {name = "Matar Trolls", start = 176201, monsters_list = {"Troll"}, level = 1, count = 50, points = 2, items = {}, reward = {{2789, 5}}, exp = 2000, money = 800},
    [2] = {name = "Matar Rotworm", start = 176201, monsters_list = {"Rotworm"}, level = 1, count = 50, points = 2, items = {}, reward = {{2789, 10}}, exp = 3000, money = 1000},
	[3] = {name = "Matar Dwarf Soldier", start = 176201, monsters_list = {"Dwarf Soldier"}, level = 1, count = 50, points = 2, items = {}, reward = {{2789, 10}}, exp = 3000, money = 2000},
    [4] = {name = "Matar Cyclops", start = 176201, monsters_list = {"Cyclops"}, level = 15, count = 100, points = 3, items = {}, reward = {{2789, 10}}, exp = 5000, money = 4000},
	[5] = {name = "Matar Dwarf Guard", start = 176201, monsters_list = {"Dwarf Guard"}, level = 20, count = 100, points = 2, items = {}, reward = {{2789, 10}}, exp = 4000, money = 5000},
	[6] = {name = "Matar Wyvern", start = 176201, monsters_list = {"Wyvern"}, level = 30, count = 200, points = 2, items = {}, reward = {{2789, 30}}, exp = 10000, money = 6000},
	[7] = {name = "Matar Dragon", start = 176201, monsters_list = {"Dragon"}, level = 45, count = 200, points = 2, items = {}, reward = {{2516, 1}}, exp = 15000, money = 7000},

}

dailyTasks = {
	[1] = {name = "Matar Dwarf Soldier", monsters_list = {"Dwarf Soldier"}, level = 1, count = 50, points = 2, items = {}, reward = {{2789, 10}}, exp = 3000, money = 2000},
    [2] = {name = "Matar Cyclops", monsters_list = {"Cyclops"}, level = 15, count = 100, points = 3, items = {}, reward = {{2789, 10}}, exp = 5000, money = 4000},
	[3] = {name = "Matar Dwarf Guard", monsters_list = {"Dwarf Guard"}, level = 20, count = 100, points = 2, items = {}, reward = {{2789, 10}}, exp = 4000, money = 5000},
}
                   -- task, points, count, daily task, daily count, daily time , daily start, contador
taskSystem_storages = {176601, 176602, 176603, 176604, 176605, 176606, 176607, 176608}

function Player:getTaskMission()
    return self:getStorageValue(taskSystem_storages[1]) < 0 and 1 or self:getStorageValue(taskSystem_storages[1])
end

function Player:getDailyTaskMission()
    return self:getStorageValue(taskSystem_storages[4]) < 0 and 1 or self:getStorageValue(taskSystem_storages[4])
end

function Player:getTaskPoints()
    return self:getStorageValue(taskSystem_storages[2]) < 0 and 0 or self:getStorageValue(taskSystem_storages[2])
end

function Player:randomDailyTask()
    local eligible = {}
    for id, task in pairs(dailyTasks) do
        if self:getLevel() >= 1 then -- ou defina faixas de level aqui se quiser
            table.insert(eligible, id)
        end
    end
    if #eligible == 0 then return 0 end
    return eligible[math.random(#eligible)]
end

function Player:getRankTask()
    local ranks = {
        [{1, 20}] = "Iniciante",
        [{21, 50}] = "Rastreador",
        [{51, 100}] = "Mestre das Trilhas",
        [{101, 200}] = "Predador",
        [{201, math.huge}] = "Predador Ancestral"
    }

    local defaultRank = "Forasteiro"

    for v, r in pairs(ranks) do
        if self:getTaskPoints() >= v[1] and self:getTaskPoints() <= v[2] then
            return r
        end
    end

    return defaultRank
end

function getItemsFromList(items)
    local str = ''
    if #items > 0 then
        for i = 1, #items do
            local itemID = items[i][1]
            local itemName = ItemType(itemID):getName()
            if itemName then
                str = str .. items[i][2] .. ' ' .. itemName
            else
                str = str .. items[i][2] .. ' ' .. "Item ID: " .. itemID
            end
            if i ~= #items then str = str .. ', ' end
        end
    end
    return str
end


function Player:doRemoveItemsFromList(items)
    local count = 0
    if #items > 0 then
        for i = 1, #items do
            if self:getItemCount(items[i][1]) >= items[i][2] then
                count = count + 1
            end
        end
    end
    if count == #items then
        for i = 1, #items do
            self:removeItem(items[i][1], items[i][2])
        end
    else
        return false
    end
    return true
end

function getMonsterFromList(monster)
    local str = ''
    if #monster > 0 then
        for i = 1, #monster do
            str = str .. monster[i]
            if i ~= #monster then str = str .. ', ' end
        end
    end
    return str
end

function Player:giveRewardsTask(items)
    local backpack = self:addItem(1999, 1)
    for _, i_i in ipairs(items) do
        local item, amount = i_i[1], i_i[2]
        if ItemType(item):isStackable() or amount == 1 then
            backpack:addItem(item, amount)
        else
            for i = 1, amount do
                backpack:addItem(item, 1)
            end
        end
    end
end