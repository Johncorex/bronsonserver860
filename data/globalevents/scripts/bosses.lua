
local shit = {
    {boss = "Smaug", pos = {x=1404, y=377, z=3}},
	{boss = "laracna", pos = {x=980, y=866, z=12}},
	{boss = "son of ancalagon", pos = {x=955, y=369, z=8}},
	{boss = "son of ancalagon", pos = {x=1651, y=615, z=12}},
	{boss = "Wormageddon", pos = {x=331, y=390, z=8}},
	{boss = "Wormageddon", pos = {x=274, y=832, z=9}},
	{boss = "olog-hai", pos = {x=1664, y=1141, z=8}},
	{boss = "olog-hai", pos = {x=507, y=835, z=10}},
	{boss = "scatha", pos = {x=1394, y=210, z=9}},
	{boss = "valaraukar", pos = {x=554, y=295, z=1}},
	{boss = "valaraukar", pos = {x=332, y=508, z=4}},
    {boss = "ferumbras", pos = {x=1865, y=811, z=0}},
	--{boss = "jormungand", pos = {x=616, y=518, z=9}},
	{boss = "adramelech", pos = {x=1666, y=517, z=11}},
	{boss = "ancalagon", pos = {x=1630, y=851, z=14}},
	{boss = "smaug", pos = {x=1401, y=382, z=3}},
    --{boss = "eddie", pos = {x=1636, y=458, z=11}},
	{boss = "the necromancer", pos = {x=557, y=315, z=0}},
	{boss = "The Necromancer", pos = {x=337, y=706, z=1}},
	{boss = "baalrog", pos = {x=553, y=761, z=9}},
	{boss = "emelianenko", pos = {x=1206, y=766, z=11}},
	{boss = "khel thuzad", pos = {x=1788, y=453, z=15}},
	{boss = "ungoliant", pos = {x=1790, y=374, z=6}},
	{boss = "saruman", pos = {x=959, y=983, z=1}},
    {boss = "cerberus", pos = {x=1779, y=355, z=12}},
	{boss = "scatha", pos = {x=1104, y=1183, z=0}},
	{boss = "azaka", pos = {x=537, y=196, z=6}},
	{boss = "Melkors Summon", pos = {x=1540, y=94, z=13}},
	{boss = "Melkors Summon", pos = {x=309, y=846, z=9}},
	{boss = "Avari Leader", pos = {x=978, y=1341, z=8}},
	{boss = "Azazel", pos = {x=374, y=182, z=9}},
	{boss = "Lord of The Elements", pos = {x=127, y=818, z=13}},
	--{boss = "deathstrike", pos = {x=1431, y=484, z=9}},
	--{boss = "Obujos", pos = {x=651, y=1153, z=13}},
    --{boss = "Jaul", pos = {x=775, y=1162, z=13}},
    --{boss = "Evancing", pos = {x=777, y=1514, z=12}},
	--{boss = "Glooth Fairy", pos = {x=535, y=1491, z=7}},
	--{boss = "Zamulosh", pos = {x=1848, y=352, z=13}},
	--{boss = "Sauron", pos = {x=1630, y=1142, z=8}}
}

function onThink(interval)
    local nomonster = {}
    for i, v in ipairs(shit) do
        local creature = Creature(v.boss)
        if not creature then
            table.insert(nomonster, i)
        end
    end

    if #nomonster == 0 then return true end

    local r = nomonster[math.random(1, #nomonster)]
    local creature = Game.createMonster(shit[r].boss, shit[r].pos, true, true)

    if creature then
        print("[Boss Spawn Debug] Criado boss: " .. shit[r].boss .. 
              " em (" .. shit[r].pos.x .. ", " .. shit[r].pos.y .. ", " .. shit[r].pos.z .. ")")
    else
        print("[Boss Spawn Debug] Falha ao criar boss: " .. shit[r].boss)
    end

    return true
end
