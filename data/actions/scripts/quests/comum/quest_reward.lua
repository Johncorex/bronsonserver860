-- For full information, visit http://otfans.net/showthread.php?p=849367
-- a magic sword, 5 meats and a key with actionId 2149
-- parameters = {rewards = {{2400}, {2666, 5}, {2086, 1, 2149}}, storageValue = item.uid, itemName = getItemName(item.itemid)}

function onUse(cid, item, frompos, item2, topos)
--		-- Frosts - Hailstorm rod {x = 925, y = 67, z = 4}
	if (item.uid == 1001) then
		parameters = {reward = {2183}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Black Knights - Knight Axe {x = 926, y = 381, z = 6}		
	elseif (item.uid == 1002) then
		parameters = {reward = {2430}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}


--		-- Dwarfs - dwarven legs {x = 1404, y = 382, z = 4}	
	elseif (item.uid == 1003) then
		parameters = {reward = {2504}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Amazons - ripper lance {x = 756, y = 608, z = 5}	
	elseif (item.uid == 1004) then
		parameters = {reward = {3964}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Cathedral - Blue Robe {x = 855, y = 627, z = 9}		
	elseif (item.uid == 1005) then
		parameters = {reward = {2656}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Cathedral - Skull Staff  {x = 852, y = 627, z = 9}	
	elseif (item.uid == 1006) then
		parameters = {reward = {2436}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Bree - Chain Armor	
	elseif (item.uid == 1007) then
		parameters = {reward = {2464}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}


--		-- Minos - Scale Armor	
	elseif (item.uid == 1008) then
		parameters = {reward = {2483}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}


--		-- Dworcs - Native Armor {x = 611, y = 176, z = 8}	
	elseif (item.uid == 1009) then
		parameters = {reward = {2508}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	

--		-- DL sub - Wand of Inferno {x = 715, y = 331, z = 8}	
	elseif (item.uid == 1010) then
		parameters = {reward = {2187}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Frosts - Red Robe {x = 919, y = 74, z = 2}	
	elseif (item.uid == 1011) then
		parameters = {reward = {2655}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Pirates - Pirate Boots {x = 158, y = 636, z = 7}	
	elseif (item.uid == 1012) then
		parameters = {reward = {5462}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Undeads - Ice Rapier {x = 1190, y = 762, z = 11}	
	elseif (item.uid == 1013) then
		parameters = {reward = {2396}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Hero - Noble Armor {x = 1063, y = 1424, z = 7}		
	elseif (item.uid == 1014) then
		parameters = {reward = {2486}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Hero - Horseman Helmet {x = 1065, y = 1424, z = 7}		
	elseif (item.uid == 1015) then
		parameters = {reward = {3969}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Pit - dark helmet {x = 1326, y = 902, z = 3}	
	elseif (item.uid == 1016) then
		parameters = {reward = {2490}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}


--		-- Terror Birds - Barbarian Axe 		
	elseif (item.uid == 1017) then
		parameters = {reward = {2429}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
	
		
--		-- Cyc - Dark Helmet {x = 1323, y = 903, z = 4}		
	elseif (item.uid == 1018) then
		parameters = {reward = {2462}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Quara - Glacier Kilt {x = 1441, y = 490, z = 9}		
	elseif (item.uid == 1019) then
		parameters = {reward = {7896}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Pirata - Helmet of the Deep {x = 552, y = 1201, z = 3}
		
	elseif (item.uid == 1020) then
		parameters = {reward = {5461}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- GS - Arcane Wand {x = 1019, y = 877, z = 11}		
	elseif (item.uid == 1021) then
		parameters = {reward = {2453}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Barbarians - Glacier Boots {x = 977, y = 41, z = 6}		
	elseif (item.uid == 1022) then
		parameters = {reward = {7892}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		

--		-- Macacos - {x = 1377, y = 753, z = 8}		
	elseif (item.uid == 1023) then
		parameters = {reward = {2087,1,3001}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Macacos - 		
	elseif (item.uid == 1024) then
		parameters = {reward = {2087,1,3002}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		-- Macacos - 	
	elseif (item.uid == 1025) then
		parameters = {reward = {2087,1,3003}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}


--		-- Hellhounds - Magma Legs {x = 523, y = 479, z = 5}		
	elseif (item.uid == 1026) then
		parameters = {reward = {7894}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}		

	
--		-- Lava Succubus - Magma Coat		
	elseif (item.uid == 1028) then
		parameters = {reward = {7899}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		

--		-- Orc Fortress - sapphire hammer		
	elseif (item.uid == 1029) then
		parameters = {reward = {7437}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		-- Warlock Rhun - Fire Axe {x = 1857, y = 775, z = 8}		
	elseif (item.uid == 1030) then
		parameters = {reward = {2432}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		
--		-- Ferumbras - Saruman Scepter {x = 1864, y = 808, z = 0}		
	elseif (item.uid == 1031) then
		parameters = {reward = {7451}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Dragon VIP - Ring of the Tarrasque {x = 1522, y = 727, z = 8}		
	elseif (item.uid == 1032) then
		parameters = {reward = {8752}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}


--		--  Frost Razor {x = 1278, y = 1252, z = 0}
	elseif (item.uid == 1033) then
		parameters = {reward = {7455}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Bright Sword	
	elseif (item.uid == 1034) then
		parameters = {reward = {2407}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Crossbow	
	elseif (item.uid == 1035) then
		parameters = {reward = {2455}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  BOH {x = 987, y = 865, z = 12}	
	elseif (item.uid == 1036) then
		parameters = {reward = {2195}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Crown	
	elseif (item.uid == 1037) then
		parameters = {reward = {2128}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  glacier robe {x = 615, y = 56, z = 9}		
	elseif (item.uid == 1038) then
		parameters = {reward = {7897}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		

--		--  Aghanim legs		
	elseif (item.uid == 1039) then
		parameters = {reward = {7895}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		


--		--  golden key {x = 1351, y = 1331, z = 9}		
	elseif (item.uid == 1040) then
		parameters = {reward = {2091,1,666}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  motaba wand	
	elseif (item.uid == 1041) then
		parameters = {reward = {7379}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  cyc 1 dark armor {x = 1035, y = 748, z = 10}		
	elseif (item.uid == 1042) then
		parameters = {reward = {2489}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
			
--		--  light shovel 1059, 701, 5		
	elseif (item.uid == 1043) then
		parameters = {reward = {5710}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  ice rapier {x = 647, y = 136, z = 8}		
	elseif (item.uid == 1044) then
		parameters = {reward = {2396}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
			

--		--  amazon armor		
	elseif (item.uid == 1045) then
		parameters = {reward = {2500}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	

--		--  Ancient Rune	
	elseif (item.uid == 1046) then
		parameters = {reward = {2348}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Guardian Shield {x = 1481, y = 917, z = 7}	
	elseif (item.uid == 1047) then
		parameters = {reward = {2515}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
				
		
--		--  Guardian Halberd {x = 313, y = 699, z = 7}		
	elseif (item.uid == 1048) then
		parameters = {reward = {2427}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		

--		--  Gandalf Ring 1681, 1098, 9		
	elseif (item.uid == 1049) then
		parameters = {reward = {2357}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	

--		--  Soft Boots {x = 1769, y = 1086, z = 11}	
	elseif (item.uid == 1050) then
		parameters = {reward = {2640}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Aghanim Boots {x = 956, y = 365, z = 8}		
	elseif (item.uid == 1051) then
		parameters = {reward = {7893}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  FURY - Holly Orchid {x = 1002, y = 337, z = 11}		
	elseif (item.uid == 1052) then
		parameters = {reward = {5922}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Pirate Boots {x = 153, y = 665, z = 4}		
	elseif (item.uid == 1053) then
		parameters = {reward = {5462}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Tower Shield {x = 1037, y = 659, z = 11}		
	elseif (item.uid == 1054) then
		parameters = {reward = {2528}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Damaged Helmet		
	elseif (item.uid == 1055) then
		parameters = {reward = {2339}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  helmet ornament		
	elseif (item.uid == 1056) then
		parameters = {reward = {2335}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		

--		--   piece of helmet of the ancient		
	elseif (item.uid == 1057) then
		parameters = {reward = {2336}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  piece of helmet of the ancient		
	elseif (item.uid == 1058) then
		parameters = {reward = {2337}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  piece of helmet of the ancient		
	elseif (item.uid == 1059) then
		parameters = {reward = {2338}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  piece of helmet of the ancient		
	elseif (item.uid == 1060) then
		parameters = {reward = {2340}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  piece of helmet of the ancient		
	elseif (item.uid == 1061) then
		parameters = {reward = {2341}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  terra amulet	
	elseif (item.uid == 1062) then
		parameters = {reward = {7887}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  cook book {x = 653, y = 204, z = 8}		
	elseif (item.uid == 1063) then
		parameters = {reward = {2347}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  strange book {x = 1326, y = 1530, z = 8}		
	elseif (item.uid == 1064) then
		parameters = {reward = {6103}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  defiler remains {x = 1348, y = 1519, z = 6}		
	elseif (item.uid == 1065) then
		parameters = {reward = {6552}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  aghanim robe {x = 1658, y = 511, z = 12}		
	elseif (item.uid == 1066) then
		parameters = {reward = {7898}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  slingshot		
	elseif (item.uid == 1067) then
		parameters = {reward = {5907}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  elven bow {x = 1605, y = 586, z = 8}	
	elseif (item.uid == 1068) then
		parameters = {reward = {7438}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  vampire dust		
	elseif (item.uid == 1069) then
		parameters = {reward = {6551}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  amulet of loss		
	elseif (item.uid == 1070) then
		parameters = {reward = {2173}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  bruning heart {x = 263, y = 361, z = 6}		
	elseif (item.uid == 1071) then
		parameters = {reward = {2353}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  steel helmet {x = 1094, y = 797, z = 6}	
	elseif (item.uid == 1072) then
		parameters = {reward = {2457}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  brass armor 1051, 947, 4		
	elseif (item.uid == 1073) then
		parameters = {reward = {2465}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  scale armor {x = 1485, y = 905, z = 8}		
	elseif (item.uid == 1074) then
		parameters = {reward = {2483}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  scimitar		
	elseif (item.uid == 1075) then
		parameters = {reward = {2419}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  brass legs		
	elseif (item.uid == 1076) then
		parameters = {reward = {2478}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  crocodile boots {x = 764, y = 1065, z = 8}
	elseif (item.uid == 1077) then
		parameters = {reward = {3982}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  battle axe		
	elseif (item.uid == 1078) then
		parameters = {reward = {2378}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  mysterious fetish 780, 836, 7	
	elseif (item.uid == 1079) then
		parameters = {reward = {2194}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
-- 		--  drum {x = 814, y = 806, z = 5}		
	elseif (item.uid == 1080) then
		parameters = {reward = {2367}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		

--		--  plate armor {x = 941, y = 677, z = 7}		
	elseif (item.uid == 1081) then
		parameters = {reward = {2463}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  black perl {x = 724, y = 602, z = 6}		
	elseif (item.uid == 1082) then
		parameters = {reward = {2144}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  dwarven legs {x = 992, y = 522, z = 5}		
	elseif (item.uid == 1083) then
		parameters = {reward = {2504}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  green gem		
	elseif (item.uid == 1084) then
		parameters = {reward = {2155}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  iron helmet {x = 814, y = 551, z = 8}		
	elseif (item.uid == 1085) then
		parameters = {reward = {2459}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  wand of cosmic energy {x = 812, y = 411, z = 8}		
	elseif (item.uid == 1086) then
		parameters = {reward = {2189}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Saurons Breath Scepter {x = 558, y = 316, z = 0}	
	elseif (item.uid == 1087) then
		parameters = {reward = {8910}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Dark Lords Cape {x = 558, y = 316, z = 0}	
	elseif (item.uid == 1088) then
		parameters = {reward = {8865}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Warsinger Bow	
	elseif (item.uid == 1089) then
		parameters = {reward = {8854}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Ancient Tiara	
	elseif (item.uid == 1090) then
		parameters = {reward = {2139}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Phoenix Plate {x = 1785, y = 351, z = 11}	
	elseif (item.uid == 1091) then
		parameters = {reward = {8877}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  Vile Axe {x = 1785, y = 351, z = 11}	
	elseif (item.uid == 1021) then
		parameters = {reward = {7388}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Emerald Sword {x = 1691, y = 1182, z = 9}		
	elseif (item.uid == 1093) then
		parameters = {reward = {8930}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Backpack Yalahar		
	elseif (item.uid == 1094) then
		parameters = {reward = {9774}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Icicle		
	elseif (item.uid == 1095) then
		parameters = {reward = {4848}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Blue Note		
	elseif (item.uid == 1096) then
		parameters = {reward = {2349}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Crystaline Armor {x = 1104, y = 1186, z = 0}		
	elseif (item.uid == 1097) then
		parameters = {reward = {8878}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Tear of Daraman {x = 864, y = 1179, z = 0}		
	elseif (item.uid == 1098) then
		parameters = {reward = {2346}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Hailstorm Rod {x = 1262, y = 1241, z = 4}		
	elseif (item.uid == 1099) then
		parameters = {reward = {2183}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Griffen shield		
	elseif (item.uid == 1100) then
		parameters = {reward = {2533}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	
	
--		--  oxyurus Raspberry	
	elseif (item.uid == 1101) then
		parameters = {reward = {8840,1}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Raspberry		
	elseif (item.uid == 1102) then
		parameters = {reward = {8840,1}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Shield of Honor		
	elseif (item.uid == 1103) then
		parameters = {reward = {2517}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Yellow Gem {x = 679, y = 594, z = 8}		
	elseif (item.uid == 1104) then
		parameters = {reward = {2154}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Native Armor		
	elseif (item.uid == 1105) then
		parameters = {reward = {2508}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		
		--  Gold Nugget		
	elseif (item.uid == 1106) then
		parameters = {reward = {2157}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Magician Hat {x = 535, y = 198, z = 6}		
	elseif (item.uid == 1107) then
		parameters = {reward = {2323}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Divine Armor		
	elseif (item.uid == 1108) then
		parameters = {reward = {9776}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Legolas Plate		
	elseif (item.uid == 1109) then
		parameters = {reward = {8891}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Pharao Sword		
	elseif (item.uid == 1110) then
		parameters = {reward = {2446}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Zenit Cuirass		
	elseif (item.uid == 1111) then
		parameters = {reward = {11301}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Divine Robe {x = 373, y = 182, z = 9}		
	elseif (item.uid == 1112) then
		parameters = {reward = {11356}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Divine Scepter {x = 373, y = 182, z = 9}		
	elseif (item.uid == 1113) then
		parameters = {reward = {7429}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Dragon Scale Boots {x = 313, y = 843, z = 9}		
	elseif (item.uid == 1114) then
		parameters = {reward = {11118}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
--		--  Blockers Ring		
	elseif (item.uid == 1115) then				
		parameters = {reward = {2164,100}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Montaria Joaninha		
	elseif (item.uid == 1116) then		
		parameters = {reward = {15546}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Montaria Crustacio		
	elseif (item.uid == 1117) then	
		parameters = {reward = {13305}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Starlight amulet		
    elseif (item.uid == 1118) then	
		parameters = {reward = {2138}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Tempest Shield		
    elseif (item.uid == 1119) then	
		parameters = {reward = {2542}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
		
		
		--  Spirit Shovel
   elseif (item.uid == 1120) then	
		parameters = {reward = {21553}, storageValue = item.uid, itemName = getItemName(item.itemid), requiredLevel = (item.actionid - 1000)}
	else
		return TRUE
	end
	
	



    local rewardProtection = parameters.rewardProtection
    local requiredVocation = parameters.requiredVocation
    local requiredSex = parameters.requiredSex
    local requiredLevel = parameters.requiredLevel
    local requiredMagicLevel = parameters.requiredMagicLevel
    local requiredSoul = parameters.requiredSoul
    local requiredStorageValue = parameters.requiredStorageValue
    local premiumRequired = parameters.premiumRequired
    local itemName = parameters.itemName
    local storageValue = parameters.storageValue
    local containerId = parameters.containerId
    local reward = parameters.reward
    local rewards = parameters.rewards
    local playerMagicEffect = parameters.playerMagicEffect
    
   
    if (rewardProtection ~= nil and getPlayerAccess(cid) >= rewardProtection) then
        if (itemName ~= nil) then
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Esta " .. itemName .. " esta vazia.")
        else
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Esta vazio.")
        end
        
        return TRUE
    end
   
    
    if (storageValue ~= nil and getPlayerStorageValue(cid, storageValue) > 0) then
        if (itemName ~= nil) then
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Esta " .. itemName .. " esta vazia.")
        else
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Esta vazio.")
        end
        
        return TRUE
    end
    
    if (requiredVocation ~= nil) then
        if (type(requiredVocation) == "table") then
            if (isInArray(requiredVocation, getPlayerVocation(cid)) == FALSE) then
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sua classe nao pode completar esta quest.")
                
                return TRUE
            end
        else
            if (getPlayerVocation(cid) ~= requiredVocation) then
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sua classe nao pode completar esta quest.")
                
                return TRUE
            end
        end
    end
    
    if (requiredSex ~= nil and getPlayerSex(cid) ~= requiredSex) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your sex can not to take this reward.")
        
        return true
    end
    
    if (requiredLevel ~= nil and getPlayerLevel(cid) < requiredLevel) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce nao tem level suficiente.")
        
        return true
    end
    
    if (requiredMagicLevel ~= nil and getPlayerMagLevel(cid) < requiredMagicLevel) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You do not have enought magic level to take this reward.")
        
        return true
    end
    
    if (requiredSoul ~= nil and getPlayerSoul(cid) < requiredSoul) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You do not have enought soul to take this reward.")
        
        return true
    end
    
    if (requiredStorageValue ~= nil and getPlayerStorageValue(cid, requiredStorageValue) <= 0) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You do not can take this reward yet.")
        
        return true
    end
    
    if (premiumRequired ~= nil and premiumRequired >= 1 and isPremium(cid) == FALSE) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce precisa ser VIP para terminar esta quest.")
        
        return true
    end
    
    local leftSlot = getPlayerSlotItem(cid, CONST_SLOT_LEFT)
    local rightSlot = getPlayerSlotItem(cid, CONST_SLOT_RIGHT)
    local ammunitionSlot = getPlayerSlotItem(cid, CONST_SLOT_AMMO)
    local backpackSlot = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
    
    if (leftSlot.itemid > 0 and rightSlot.itemid > 0 and ammunitionSlot.itemid > 0 and (isContainer(backpackSlot.uid) == FALSE or getContainerCap(backpackSlot.uid) == getContainerSize(backpackSlot.uid))) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce nao tem espaco suficiente.")
        
        return FALSE
    end
    
    if (reward ~= nil and rewards == nil) then
        if (reward[1] == nil) then
            debugPrint("doPlayerAddQuestReward() - reward ID not found")
            
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Error. Please report to a gamemaster.")
            
            return FALSE
        end
        
        if (reward[2] == 0 or reward[2] == nil) then
            reward[2] = 1
        end
        
        local rewardEx = doCreateItemEx(reward[1], reward[2])
        local rewardWeight = getItemWeight(rewardEx)
        local i = 1
        
        doRemoveItem(rewardEx)
        
        if (rewardWeight > getPlayerFreeCap(cid)) then
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O item esta pesado demais pra voce.")
            
            return FALSE
        end
        
        local rewardDescriptions = getItemDescriptions(reward[1])
        
        if (reward[2] == 1 or isItemRune(reward[1]) == TRUE or isItemFluidContainer(reward[1]) == TRUE) then
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce encontrou " .. rewardDescriptions.article .. " " ..  rewardDescriptions.name .. ".")
        else
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce encontrou " .. reward[2] .. " " ..  rewardDescriptions.plural .. ".")
        end
        
        local reward_ = doPlayerAddItem(cid, reward[1], reward[2])
        
        if (reward[3] ~= nil) then
            doSetItemActionId(reward_, reward[3])
        end
        
        if (reward[4] ~= nil) then
            doSetItemSpecialDescription(reward_, reward[4])
        end
    else
        if (containerId == nil) then
            containerId = 1987
        end
        
        local containerEx = doCreateItemEx(containerId, 1)
        local containerWeight = getItemWeight(containerEx)
        local rewardWeight = containerWeight
        local i = 1
        
        for i, j in ipairs(rewards) do
            if (j[1] == nil) then
                debugPrint("doPlayerAddQuestReward() - #" .. i .. ", reward ID not found")
                
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Error. Please report to a gamemaster.")
                
                return FALSE
            end
            
            if (j[2] == 0 or j[2] == nil) then
                j[2] = 1
            end
            
            local rewardEx = doCreateItemEx(j[1], j[2])
            rewardWeight = rewardWeight + getItemWeight(rewardEx)
            
            doRemoveItem(rewardEx, 1)
        end
        
        if (rewardWeight > getPlayerFreeCap(cid)) then
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O item esta pesado demais pra voce.")
            
            return FALSE
        end
        
        local containerDescriptions = getItemDescriptions(containerId)
        
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce encontrou " .. containerDescriptions.article .. " " ..  containerDescriptions.name .. ".")
        
        for i, j in ipairs(rewards) do
            if (j[2] == 0 or j[2] == nil) then
                j[2] = 1
            end
            
            reward = doAddContainerItem(containerEx, j[1], j[2])
            
            if (j[3] ~= nil) then
                doSetItemActionId(reward, j[3])
            end
            
            if (j[4] ~= nil) then
                doSetItemSpecialDescription(reward, j[4])
            end
        end
        
        doPlayerAddItemEx(cid, containerEx)
    end
    
    if (playerMagicEffect ~= nil) then
        doSendMagicEffect(getPlayerPosition(cid), playerMagicEffect)
    end
    
    if (storageValue ~= nil) then
        setPlayerStorageValue(cid, storageValue, 1)
    end
    
    return TRUE
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        