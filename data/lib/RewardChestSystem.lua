-- Reward system created by luanluciano93 for TFS 0.4, function adapted by Mateus Roberto for TFS 1.3+ using RevScripts.

REWARDCHEST = {
    rewardBagId = 10519,
    formula = {hit = 1, block = 2, support = 9},
    storageExhaust = 60000,
    town_id = 2,
    bosses = {
        ["gurthnaur"] = -- the boss's entire name in lower case.
        {
            common = {
                {2149, 30, 100}, -- small emeralds
                {2179, 1, 100}, -- gold ring
            },

            semiRare = {
                {2195, 1, 100}, -- BOOTS OF HASTE
                {2393, 1, 100}, -- GIANT SWORD
				{2421, 1, 25}, -- Thunder Hammer
				{2432, 1, 100}, -- Fire Axe

            },

            rare = {
                {6391, 1, 40}, -- Nightmare Shield
                {9932, 1, 50}, -- Firewalker Boots
				{2493, 1, 50}, -- Demon Helmet
				{8300, 1, 5}, -- Cristal Impecavel

            },

            veryRare = {
                {9777, 1, 5}, -- Valar Kilt
                {8886, 1, 5}, -- Molten Plate
				{7840, 1, 5}, -- Flaming Arrow
            },
        
            always = {
                {6500, 15, 100}, -- demonic essence
                {2214, 1, 100}, -- ring of healing
				{10518, 1, 100}, -- Demon Backpack
            },
        
            storage = 65479,
        },
    
        ["orshabaal"] = -- the boss's entire name in lower case.
        {
            common = {
                {2143, 10, 100}, -- white pearl
                {2146, 10, 100}, -- small sapphire
                {2145, 10, 100}, -- small diamond
                {2144, 10, 100}, -- black pearl
                {2149, 10, 100}, -- small emeralds
                {5954, 3, 100}, -- demon horn
                {7896, 1, 100}, -- glacier kilt
                {2432, 1, 100}, -- fire axe
                {2462, 1, 100}, -- devil helmet
                {7590, 1, 100}, -- great mana potion
                {2179, 1, 100}, -- gold ring
                {2151, 1, 100}, -- talon
            },

            semiRare = {
                {2195, 1, 100}, -- boots of haste
                {2436, 1, 100}, -- skull staff
                {2393, 1, 100}, -- giant sword
                {5954, 5, 100}, -- demon horn
            },

            rare = {
                {2470, 1, 100}, -- golden legs
                {2472, 1, 100}, -- magic plate armor
                {2514, 1, 100}, -- mastermind shield
                {2520, 1, 100}, -- demon shield
                {1982, 1, 100}, -- purple tome
                {2123, 1, 100}, -- ring of the sky
            },

            veryRare = {
                {8890, 1, 100}, -- robe of the underworld
                {2421, 1, 100}, -- thunder hammer
            },
        
            always = {
                {5808, 1, 100}, -- orshabaal's brain
                {2171, 1, 100}, -- platinum amulet
                {2148, 90, 100}, -- gold coin
                {2146, 10, 100}, -- small sapphire
            },
        
            storage = 65480,
        },
    
        ["ferumbras"] = -- the boss's entire name in lower case.
        {
            common = {
                {2143, 10, 100}, -- white pearl
                {2146, 10, 100}, -- small sapphire
                {2145, 10, 100}, -- small diamond
                {2144, 10, 100}, -- black pearl
                {2149, 10, 100}, -- small emeralds
                {7416, 1, 100}, -- bloody edge
                {7896, 1, 100}, -- glacier kilt
                {2432, 1, 100}, -- fire axe
                {2462, 1, 100}, -- devil helmet
                {7590, 1, 100}, -- great mana potion
                {2179, 1, 100}, -- gold ring
                {2151, 1, 100}, -- talon
            },

            semiRare = {
                {2195, 1, 100}, -- boots of haste
                {2472, 1, 100}, -- magic plate armor
                {2393, 1, 100}, -- giant sword
                {2470, 1, 100}, -- golden legs
                {2514, 1, 100}, -- mastermind shield
            },

            rare = {
                {8885, 1, 100}, -- divine plate
                {2520, 1, 100}, -- demon shield
                {8930, 1, 100}, -- emerald sword
                {2522, 1, 100}, -- great shield
                {2421, 1, 100}, -- thunder hammer
            },

            veryRare = {
                {5903, 1, 100}, -- ferumbras' hat
            },
        
            always = {
                {2171, 1, 100}, -- platinum amulet
                {2148, 90, 100}, -- gold coin
                {2146, 10, 100}, -- small sapphire
            },
        
            storage = 65481,
        },
        ["zulazza the corruptor"] = --- the boss's entire name in lower case.
        {
            common = {
                {2158, 1, 100}, -- blue gem
                {2156, 1, 100}, -- red gem
                {2155, 1, 100}, -- green gem
                {2154, 1, 100}, -- yellow gem
                {2153, 1, 100}, -- violet gem
            },

            semiRare = {
                {5944, 5, 100}, -- soul orb
            },

            rare = {
                {2514, 1, 100}, -- mastermind shield
            },

            veryRare = {
                {11114, 1, 100}, -- dragon scale boots
                {8882, 1, 100}, -- earthborn titan armor
            },
        
            always = {
                {2152, 90, 100}, -- platinum coin
                {9971, 5, 100}, -- gold ingot
            },
        
            storage = 65482,
        },
        ["morgaroth"] = -- the boss's entire name in lower case.
        {
            common = {
                {2143, 10, 100}, -- white pearl
                {2146, 10, 100}, -- small sapphire
                {2145, 10, 100}, -- small diamond
                {2144, 10, 100}, -- black pearl
                {2149, 10, 100}, -- small emeralds
                {5954, 3, 100}, -- demon horn
                {7896, 1, 100}, -- glacier kilt
                {2432, 1, 100}, -- fire axe
                {2462, 1, 100}, -- devil helmet
                {7590, 1, 100}, -- great mana potion
                {2179, 1, 100}, -- gold ring
                {2151, 1, 100}, -- talon
            },

            semiRare = {
                {2195, 1, 100}, -- boots of haste
                {2393, 1, 100}, -- giant sword
                {5954, 5, 100}, -- demon horn
                {2123, 1, 100}, -- ring of the sky
            },

            rare = {
                {8886, 1, 100}, -- molten plate
                {2472, 1, 100}, -- magic plate armor
                {8867, 1, 100}, -- dragon robe
                {2514, 1, 100}, -- mastermind shield
                {2520, 1, 100}, -- demon shield
                {1982, 1, 100}, -- purple tome
                {8851, 1, 100}, -- royal crossbow
            },

            veryRare = {
                {2421, 1, 100}, -- thunder hammer
                {2522, 1, 100}, -- great shield
                {8850, 1, 100}, -- chain bolter
            },
        
            always = {
                {5943, 1, 100}, -- morgaroth's brain
                {2171, 1, 100}, -- platinum amulet
                {2148, 90, 100}, -- gold coin
                {2146, 10, 100}, -- small sapphire
            },
            storage = 65483,
        },
    }
}