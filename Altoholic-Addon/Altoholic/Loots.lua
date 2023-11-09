﻿local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local lootTable, lootTableRev
do
	-- Simplified loot table containing item ID's only, based on AtlasLoot v5.09.00
	lootTable = {
				
		-- to do: HardModeArena & HardModeArena2 from sets_en.lua
		-- to do : wotlk crafts
		-- to do : pvp non set 80, line 3000 in wotlk.lua of AL 5.04
		-- tier 8

		-- ** Miscellaneous **
		[L["Bash'ir Landing"]] = {	
			[L["Skyguard Raid"]] = { 32596, 32600, 32599, 32597, 32634, 32637, 32635, 32636, 32639, 32638, 
									32641, 32640, 32759, 32630, 32631, 32627, 32625, 32629, 32628, 32626, 32624 },
			[L["Stasis Chambers"]] = { 32522, 31577, 31569, 31553, 31561},
		},
		[L["Skettis"]] = {	
			[L["Time-Lost Scroll"] .. ": " .. SUMMONS] = {
				31558, 31555, 31566, 31563, 31574, 31571, 31582, 31579, 32514 },
			[L["Time-Lost Scroll"] .. ": " .. L["Darkscreecher Akkarai"]] = {
				32529, 32715 },
			[L["Time-Lost Scroll"] .. ": " .. L["Karrog"]] = {
				32533, 32717 },
			[L["Time-Lost Scroll"] .. ": " .. L["Gezzarak the Huntress"]] = {
				32531, 32716 },
			[L["Time-Lost Scroll"] .. ": " .. L["Vakkiz the Windrager"]] = {
				32532, 32718 },
			[L["Terokk"]] = { 32540, 32541, 31556, 31564, 31572, 31580, 32535, 32534, 32782, 32536, 32537 }
		},
		[L["Ethereum Prison"]] = {	
			[L["Armbreaker Huffaz"]] = { 31943, },
			[L["Fel Tinkerer Zortan"]] = { 31573, },
			[L["Forgosh"]] = { 31565, },
			[L["Gul'bor"]] = {31940, },
			[L["Malevus the Mad"]] = { 31581, },
			[L["Porfus the Gem Gorger"]] = { 31557, },
			[L["Wrathbringer Laz-tarash"]] = { 32520, },
			["Shared loot"] = { 31925, 31926, 31927, 31928, 31929, 31935, 31936, 31937, 31938, 31939, 31957 },
		},
		[L["Abyssal Council"] .. " (" .. BZ["Silithus"] .. ")"] = {	
			[L["Crimson Templar (Fire)"]] = { 20657, 20655, 20656	},
			[L["Azure Templar (Water)"]] = { 20654, 20652, 20653 },
			[L["Hoary Templar (Wind)"]] = { 20658, 20659, 20660 },
			[L["Earthen Templar (Earth)"]] = { 20661, 20662, 20663 },
			[L["The Duke of Cinders (Fire)"]] = { 20665, 20666, 20664, 21989 },
			[L["The Duke of Fathoms (Water)"]] = { 20668, 20669, 20667 },
			[L["The Duke of Zephyrs (Wind)"]] = { 20674, 20675, 20673 },
			[L["The Duke of Shards (Earth)"]] = { 20671, 20672, 20670 },
			[L["Dukes"]] = { 20514, },
			
			[BB["Prince Skaldrenox"] .. " (Fire)"] = { 20682, 20681, 20680	},
			[BB["Lord Skwol"] .. " (Water)"] = {	20685, 20684, 20683 },
			[BB["High Marshal Whirlaxis"] .. " (Wind)"] = { 20691, 20690, 20689 },
			[BB["Baron Kazum"] .. " (Earth)"] = { 20688, 20686, 20687 },
			[L["Princes"]] = { 20515, },
			
		},
		[L["Elemental Invasion"]] = {	
			[BB["Baron Charr"] .. " (" .. BZ["Un'Goro Crater"] .. ")"] = {	18671, 18672 }, 	-- 19268, 
			[BB["Princess Tempestria"] .. " (" .. BZ["Winterspring"] .. ")"] = { 18678, 18679 }, 	-- 19268, 
			[BB["Avalanchion"] .. " (" .. BZ["Azshara"] .. ")"] = { 18673, 18674 }, 	-- 19268, 
			[BB["The Windreaver"] .. " (" .. BZ["Silithus"] .. ")"] = { 18676, 18677 }, 	-- 19268, 
			[format("%s/ %s", BZ["Silithus"], BZ["Winterspring"])] = { 21548 }, 	-- 19268, 
		},
		[L["Gurubashi Arena"]] = {	
			[L["Booty Run"]] = { 18709, 18710, 18711, 18712, 18706, 19024 }
		},
		[L["Fishing Extravaganza"]] = {	
			[L["First Prize"]] = { 19970, 19979	},
			[L["Rare Fish"]] = { 19805, 19803, 19806, 19808 },
			[L["Rare Fish Rewards"]] = { 19972, 19969, 19971 }
		},
		[L["Children's Week"]] = {	
			[BZ["Azeroth"]] = { 23007, 23015, 23002, 23022 },
			[BZ["Outland"]] = { 32616, 32622, 32617	}
		},
		[L["Love is in the air"]] = {	
			[L["Gift of Adoration"]] = { 34480, 22279, 22235, 22200, 22261, 22218, 21813, 34258 },
			[L["Box of Chocolates"]] = { 22237, 22238, 22236, 22239 },
			[L["Quest rewards"]] = { 22276, 22278, 22280, 22277, 22281, 22282	}
		},
		[L["Hallow's End"]] = {	
			[L["Various Locations"]] = { 33117, 20400, 18633, 18632, 18635, 20557 },
			[L["Treat Bag"]] = {	20410, 20409, 20399, 20398, 20397, 20413, 20411, 20414, 20389, 20388, 
										20390, 20561, 20391, 20566, 20564, 20570, 20572, 20568, 20573, 20562, 
										20392, 20565, 20563, 20569, 20571, 20567, 20574 },
			[L["Headless Horseman"]] = { 33808, 34075, 34073, 34074, 33292, 33154, 34068, 33226, 33182, 33184, 
										33176, 33183, 33189 }
		},
		[L["Feast of Winter Veil"]] = {	
			[L["Various Locations"]] = { 21525, 21524, 17712, 17202, 34191, 21212, 21519 },
			[L["Smokywood Pastures Vendor"]] = { 34262, 34319, 34261, 34413, 17201, 17200, 17344, 17406, 17407, 17408, 
									34410, 17404, 17405, 34412, 17196, 17403, 17402, 17194, 17303, 17304, 17307 },
			[L["Gaily Wrapped Present"]] = { 21301, 21308, 21305, 21309	},
			[L["Festive Gift"]] = {	21328 },
			[L["Winter Veil Gift"]] = { 34425 },
			[L["Gently Shaken Gift"]] = {	21235, 21241 },
			[L["Ticking Present"]] = {	21325, 21213, 17706, 17725, 17720, 17722, 17709, 17724 },
			[L["Carefully Wrapped Present"]] = { 21254 },
			[L["Smokywood Pastures Extra-Special Gift"]] = { 21215 }
		},
		[L["Noblegarden"]] = {	
			[L["Brightly Colored Egg"]] = { 19028, 6833, 6835, 7807, 7808, 7806 }
		},	
		[L["Harvest Festival"]] = {	
			[L["Quest rewards"]] = { 19697, 20009, 20010 },
			[L["Food"]] = { 19994, 19995, 19996, 19997 }
		},
		[L["Scourge Invasion"]] = {	
			[L["Miscellaneous"]] = { 23123, 23122, 22999, 23194, 23195, 23196	},
			[L["Cloth Set"]] = {	23085, 23091, 23084 },
			[L["Leather Set"]] = { 23089, 23093, 23081 },
			[L["Mail Set"]] = { 23088, 23092, 23082 },
			[L["Plate Set"]] = {	23087, 23090, 23078 },
			[L["Balzaphon"]] = {	23126, 23125, 23124 },
			[L["Lord Blackwood"]] = { 23156, 23132, 23139 },
			[L["Revanchion"]] = { 23127, 23129, 23128	},
			[L["Scorn"]] = { 23170, 23169, 23168 },
			[L["Sever"]] = { 23173, 23171 },
			[L["Lady Falther'ess"]] = { 23178, 23177 }
		},
		[L["Lunar Festival"]] = {	
			[L["Miscellaneous"]] = { 21540, 21157, 21538, 21539, 21541, 21544, 21543, 21537, 21713, 21100 },
			[L["Fireworks Pack"]] = { 21558, 21559, 21557, 21561, 21562, 21589, 21590, 21592, 21593, 21595 },
			[L["Lucky Red Envelope"]] = { 21744, 21745 },
			[BI["Engineering"]] = { 21738, 21724, 21725, 21726, 21727, 21728, 21729, 21737, 21730, 21731, 
										21732, 21733, 21734, 21735 },
			[BI["Tailoring"]] = { 21722, 21723 }
		},
		[L["Midsummer Fire Festival"]] = {
			[ CURRENCY ] = {
				23247, 	-- Burning Blossom
			},
			[L["Burning Blossom"] .. format(" x%d", 350) ] = { 	
				23083, 	-- Captured Flame
				34686, 	-- Brazier of Dancing Flames
			},
			[L["Burning Blossom"] .. format(" x%d", 100) ] = { 	
				23324, 	-- Mantle of the Fire Festival
				34685, 	-- Vestment of Summer
			},
			[L["Burning Blossom"] .. format(" x%d", 200) ] = { 	34683, }, 	-- Sandals of Summer
			[L["Burning Blossom"] .. format(" x%d", 2) ] = {
				23246, 	-- Fiery Festival Brew
				34684, 	-- Handful of Summer Petals
			},
			[L["Burning Blossom"] .. format(" x%d", 5) ] = {
				23211, 	-- Toasted Smorc
				23215, 	-- Bag of Smorc Ingredients
				23326, 	-- Midsummer Sausage
				23327, 	-- Fire-toasted Bun
				23435, 	-- Elderberry Pie
				34599, 	-- Juggling Torch
			},
			[L["Miscellaneous"]] = {
				23323, 	-- Crown of the Fire Festival
				23379, 	-- Cinder Bracers (removed Lv60 Quest)
			},
			[L["Lord Ahune"] .. " (Lv70)"] = {
				34955, 	-- Scorched Stone
				
				35494, 	-- Shroud of Winter's Chill
				35495, 	-- The Frost Lord's War Cloak
				35496, 	-- Icebound Cloak
				35497, 	-- Cloak of the Frigid Winds
				35507, 	-- Amulet of Bitter Hatred
				35508, 	-- Choker of the Arctic Flow
				35509, 	-- Amulet of Glacial Tranquility
				35511, 	-- Hailstone Pendant
				35514, 	-- Frostscythe of Lord Ahune
			},
			[L["Lord Ahune"]] = {
				35279, 	-- Tabard of Summer Skies
				35280, 	-- Tabard of Summer Flames
				35498, 	-- Formula: Enchant Weapon - Deathfrost
				35720, 	-- Lord of Frost's Private Label
				35723, 	-- Shards of Ahune
				
				54801, 	-- Icebound Cloak
				54802, 	-- The Frost Lord's War Cloak
				54803, 	-- The Frost Lord's Battle Shroud
				54804, 	-- Shroud of Winter's Chill
				54805, 	-- Cloak of the Frigid Winds
			},
			[ LOOKING_FOR_DUNGEON .. " " .. LFD_REWARDS ] = {	-- global string for "Dungeon Finder" and "Rewards"
				53641,  -- Ice Chip
				54806,  -- Frostscythe of Lord Ahune
			},
		},
		[L["Shartuul"]] = {	
			[L["Blade Edge Mountains"]] = { 32941, 32676, 32675, 32677, 32678, 32672, 32673, 32674, 32670, 32671, 
										32679, 32942, 32655, 32656, 32665, 32664, 32658, 32659, 32660, 32663, 
										32661, 32662 }
		},
		[L["Brewfest"]] = {	
			[L["Miscellaneous"]] = { 33927, 33047, 33968, 33864, 33967, 33969, 33862, 33863, 33868, 33966, 
										33978, 33977, 33976, 32912, 34140, 32233, 33455, 34063, 34064, 33023, 
										33024, 33025, 33026, 33043, 33929 },
										
			[L["Barleybrew Brewery"]] = { 33030, 33028, 33029 },
			[L["Thunderbrew Brewery"]] = { 33031, 33032, 33033	},
			[L["Gordok Brewery"]] = { 33034, 33036, 33035 },
			[L["Drohn's Distillery"]] = { 34017, 34018, 34019 },
			[L["T'chali's Voodoo Brewery"]] = { 34020, 34021, 34022 },
			
			[BB["Coren Direbrew"] .. " (Lv70)"] = { 37127, 38289, 38290, 38288, 38287, 37597 },
			[BB["Coren Direbrew"]] = { 
				38280,  -- Direbrew's Dire Brew (Quest Item)
				38281,  -- Direbrew's Dire Brew (Quest Item)
				
				49078,  -- Ancient Pickled Egg
				49118,  -- Bubbling Balebrew Charm
				49116,  -- Bitter Brightbrew Charm
				49080,  -- Brawler's Souvenir
				49074,  -- Coren's Chromium Coaster
				49076,  -- Mithril Pocketwatch
			},
			[ LOOKING_FOR_DUNGEON .. " " .. LFD_REWARDS ] = {	-- global string for "Dungeon Finder" and "Rewards"
				49120,  -- Direbrew's Shanker 2.0
				48663,  -- Tankard O' Terror
				37828,  -- Great Brewfest Kodo
				-- 33977,  -- Swift Brewfest Ram (can also be bought)
				37863,  -- Direbrew's Remote
			},
		},
		
		-- ** Sets & PVP ***
		[BZ["Alterac Valley"]] = {	
			[L["Miscellaneous"].." (" .. FACTION_ALLIANCE .. ")"] = { 19045, 19032 },
			[L["Miscellaneous"].." (" .. FACTION_HORDE .. ")"] = {	19046, 19031 },
			[L["Miscellaneous"]] = { 19316, 19301, 19307, 19317, 19318	},
			[L["Superior Rewards"].." (" .. FACTION_ALLIANCE .. ")"] = { 19086, 19084, 19094, 19093, 19092, 19091, 19098, 19097, 19100, 19104, 19102, },
			[L["Superior Rewards"].." (" .. FACTION_HORDE .. ")"] = {	19085, 19083, 19090, 19089, 19088, 19087, 19096, 19095, 19099, 19103, 19101, },
			[L["Superior Rewards"] ] = {	19320, 19319, },
			[L["Epic Rewards"].." (" .. FACTION_ALLIANCE .. ")"] = { 19030 },
			[L["Epic Rewards"].." (" .. FACTION_HORDE .. ")"] = { 19029 },
			[L["Epic Rewards"]] = {	19325, 19312, 19308, 19309, 19324, 19321, 21563, 19315, 19311, 19310, 19323 }
		},
		[BZ["Arathi Basin"]] = {
			[L["Miscellaneous"].." (" .. FACTION_ALLIANCE .. ")"] = {	20225, 20227, 20226, 20243, 20237, 20244 },
			[L["Miscellaneous"].." (" .. FACTION_HORDE .. ")"] = {	20222, 20224, 20223, 20234, 20232, 20235 },
			[format(L["Lv %s Rewards"], "20-29").." (" .. FACTION_ALLIANCE .. ")"] = {	20099, 20096, 20117, 20105, 20120, 20090, 20114, 20102, 20123, 20093, 20108, 20126, 20111, 20129, 21119 },
			[format(L["Lv %s Rewards"], "20-29").." (" .. FACTION_HORDE .. ")"] = {	20164, 20162, 20191, 20172, 20152, 20197, 20188, 20169, 20201, 20157, 20178, 20207, 20182, 20210, 21120 },
			[format(L["Lv %s Rewards"], "30-39").." (" .. FACTION_ALLIANCE .. ")"] = {	20098, 20095, 20116, 20104, 20113, 20101, 21118 }, 
			[format(L["Lv %s Rewards"], "30-39").." (" .. FACTION_HORDE .. ")"] = {	20166, 20161, 20192, 20173, 20187, 20168, 21116 },
			[format(L["Lv %s Rewards"], "40-49").." (" .. FACTION_ALLIANCE .. ")"] = {	20097, 20094, 20115, 20103, 20112, 20100, 20089, 20088, 20119, 20118, 20092, 20091, 20122, 20121, 20107, 20106, 20125, 20124, 20110, 20109, 20128, 20127, 21117 }, 
			[format(L["Lv %s Rewards"], "40-49").." (" .. FACTION_HORDE .. ")"] = {	20165, 20160, 20193, 20174, 20189, 20170, 20153, 20151, 20198, 20196, 20156, 20155, 20200, 20202, 20180, 20179, 20206, 20205, 20183, 20185, 20209, 20211, 21115 },
			[format(L["Lv %s Rewards"], "50-59").." (" .. FACTION_ALLIANCE .. ")"] = {	20047, 20054, 20045, 20046, 20052, 20053, 20043, 20044, 20050, 20051, 20042, 20041, 20049, 20048, 20071 }, 
			[format(L["Lv %s Rewards"], "50-59").." (" .. FACTION_HORDE .. ")"] = {	20163, 20159, 20190, 20171, 20186, 20167, 20150, 20195, 20154, 20199, 20204, 20208, 20072 },
			[format(L["Lv %s Rewards"], "60").." (" .. FACTION_ALLIANCE .. ")"] = {	20073, 20061, 20059, 20060, 20055, 20056, 20058, 20057, 20070, 20069 }, 
			[format(L["Lv %s Rewards"], "60").." (" .. FACTION_HORDE .. ")"] = {	20068, 20176, 20194, 20175, 20158, 20203, 20212, 20214, 20220 },
		},
		[BZ["Warsong Gulch"]] = {	
			[L["Miscellaneous"].." (" .. FACTION_ALLIANCE .. ")"] = {	19506 },
			[L["Miscellaneous"].." (" .. FACTION_HORDE .. ")"] = {	19505 },
			[L["Miscellaneous"]] = { 19060, 19062, 19067, 19061, 19066, 19068 },
			[format(L["Lv %s Rewards"], "10-19").." (" .. FACTION_ALLIANCE .. ")"] = {	20428, 20444, 20431, 20439, 20443, 20440, 20434, 20438 },
			[format(L["Lv %s Rewards"], "10-19").." (" .. FACTION_HORDE .. ")"] = {	20427, 20442, 20426, 20429, 20441, 20430, 20425, 20437 },
			
			[format(L["Lv %s Rewards"], "20-29").." (" .. FACTION_ALLIANCE .. ")"] = {	19533, 19541, 19525, 19517, 19549, 19557, 19573, 19565 },
			[format(L["Lv %s Rewards"], "20-29").." (" .. FACTION_HORDE .. ")"] = {	19529, 19537, 19521, 19513, 19545, 19553, 19569, 19561 },
			[format(L["Lv %s Rewards"], "20-29")] = {	21568, 21566, },
			
			[format(L["Lv %s Rewards"], "30-39").." (" .. FACTION_ALLIANCE .. ")"] = {	19532, 19540, 19524, 19515, 19548, 19556, 19572, 19564 }, 
			[format(L["Lv %s Rewards"], "30-39").." (" .. FACTION_HORDE .. ")"] = {	19528, 19536, 19520, 19512, 19544, 19552, 19568, 19560 },
			
			[format(L["Lv %s Rewards"], "40-49").." (" .. FACTION_ALLIANCE .. ")"] = {	19531, 19539, 19523, 19516, 19547, 19555, 19571, 19563 }, 
			[format(L["Lv %s Rewards"], "40-49").." (" .. FACTION_HORDE .. ")"] = {	19527, 19535, 19519, 19511, 19543, 19551, 19567, 19559 },
			[format(L["Lv %s Rewards"], "40-49")] = {	19597, 19590, 19584, 19581, 21567, 21565, },
			
			[format(L["Lv %s Rewards"], "50-59").." (" .. FACTION_ALLIANCE .. ")"] = {	19530, 19538, 19522, 19514, 19546, 19554, 19570, 19562 }, 
			[format(L["Lv %s Rewards"], "50-59").." (" .. FACTION_HORDE .. ")"] = {	19526, 19534, 19518, 19510, 19542, 19550, 19566, 19558 },
			[format(L["Lv %s Rewards"], "50-59")] = {	19596, 19589, 19583, 19580 },
			
			[format(L["Lv %s Rewards"], "60").." (" .. FACTION_ALLIANCE .. ")"] = {	22752, 22749, 22750, 22748, 30497, 22753, 22672 }, 
			[format(L["Lv %s Rewards"], "60").." (" .. FACTION_HORDE .. ")"] = {	22747, 22740, 22741, 22673, 22676, 30498, 22651 },
			[format(L["Lv %s Rewards"], "60")] = {	19595, 19587, 19582, 19578 },
		},
		[L["World PVP"]] = {	
			[L["Hellfire Fortifications"]] = { 27833, 27786, 28360, 27830, 27785, 27777, 24520, 24579, 24522, 24581 },
			[L["Twin Spire Ruins"]] = { 27990, 27984, 27922, 27929, 27939, 27983, 27920, 27927, 27930	},
			[L["Spirit Towers (Terrokar)"]] = { 28553, 28557, 28759, 28574, 28575, 28577, 28560, 28761, 32947, 28555, 28556, 28760, 28561, 28576, 28758, 28559, 32948	},
			[L["Halaa (Nagrand)"]] = {	28915, 27679, 27649, 27648, 27650, 27647, 27652, 27654, 27653, 24208, 29228, 27680, 27638, 27645, 27637, 27646, 27643, 27644, 27639, 33783, 32071, 30611, 30615, 30598, 30597, 30599, 30612, 30571, 30570, 30568 }
		},

		[format(L["Arena Season %d"], 1)] = {	
			[L["Druid Set"]] = { 28127, 28129, 28130, 28126, 28128, 28137, 28139, 28140, 28136, 28138, 31376, 31378, 31379, 31375, 31377 },
			[L["Hunter Set"]] = { 28331, 28333, 28334, 28335, 28332 },
			[L["Mage Set"]] = { 25855, 25854, 25856, 25857, 25858 },
			[L["Paladin Set"]] = { 27704, 27706, 27702, 27703, 27705, 27881, 27883, 27879, 27880, 27882, 31616, 31619, 31613, 31614, 31618 },
			[L["Priest Set"]] = { 27708, 27710, 27711, 27707, 27709, 31410, 31412, 31413, 31409, 31411 },
			[L["Rogue Set"]] = {	25830, 25832, 25831, 25834, 25833 },
			[L["Shaman Set"]] = { 25998, 25999, 25997, 26000, 26001,27471, 27473, 27469, 27470, 27472, 31400, 31407, 31396, 31397, 31406 },
			[L["Warlock Set"]] = { 24553, 24554, 24552, 24556, 24555, 30187, 30186, 30200, 30188, 30201 },
			[L["Warrior Set"]] = { 24545, 24546, 24544, 24549, 24547 },
			[L["Weapons"]] = { 28313, 28314, 28297, 28312, 28310, 28295, 28307, 24550, 28308, 28309, 28298, 32450, 32451, 28305, 28302, 28299, 28476, 28300, 24557, 28358, 28319, 28294, 28320, 28346, 32452, 33945, 33942, 28355, 33936, 28356, 33948, 33939, 33951, 28357 }
		},
		[format(L["Arena Season %d"], 2)] = {	
			[L["Druid Set"]] = { 31968, 31971, 31972, 31967, 31969, 32057, 32059, 32060, 32056, 32058, 31988, 31990, 31991, 31987, 31989 },
			[L["Hunter Set"]] = { 31962, 31964, 31960, 31961, 31963 },
			[L["Mage Set"]] = { 32048, 32047, 32050, 32049, 32051 },
			[L["Paladin Set"]] = { 31997, 31996, 31992, 31993, 31995, 32041, 32043, 32039, 32040, 32042, 32022, 32024, 32020, 32021, 32023 },
			[L["Priest Set"]] = { 32035, 32037, 32038, 32034, 32036, 32016, 32018, 32019, 32015, 32017 },
			[L["Rogue Set"]] = {	31999, 32001, 32002, 31998, 32000 },
			[L["Shaman Set"]] = { 32006, 32008, 32004, 32005, 32007, 32011, 32013, 32009, 32010, 32012, 32031, 32033, 32029, 32030, 32032 },
			[L["Warlock Set"]] = { 31974, 31976, 31977, 31973, 31975, 31980, 31979, 31982, 31981, 31983 },
			[L["Warrior Set"]] = { 30488, 30490, 30486, 30487, 30489 },
			[L["Weapons"]] = { 32028, 32003, 32053, 32044, 32046, 32052, 32027, 31984, 31965, 31985, 31966, 32963, 32964, 32026, 31958, 31959, 32014, 32025, 32055, 33313, 33309, 32045, 32054, 31986, 32962, 31978, 32961, 33946, 33943, 33076, 33937, 33077, 33949, 33940, 33952, 33078 }
		},
		[format(L["Arena Season %d"], 3)] = {	
			[L["Druid Set"]] = { 33672, 33674, 33675, 33671, 33673, 33768, 33770, 33771, 33767, 33769, 33691, 33693, 33694, 33690, 33692 },
			[L["Hunter Set"]] = { 33666, 33668, 33664, 33665, 33667 },
			[L["Mage Set"]] = { 33758, 33757, 33760, 33759, 33761 },
			[L["Paladin Set"]] = { 33697, 33699, 33695, 33696, 33698, 33751, 33753, 33749, 33750, 33752, 33724, 33726, 33722, 33723, 33725 },
			[L["Priest Set"]] = { 33745, 33747, 33748, 33744, 33746, 33718, 33720, 33721, 33717, 33719  },
			[L["Rogue Set"]] = {	33701, 33703, 33704, 33700, 33702 },
			[L["Shaman Set"]] = { 33708, 33710, 33706, 33707, 33709, 33713, 33715, 33711, 33712, 33714, 33740, 33742, 33738, 33739, 33741 },
			[L["Warlock Set"]] = { 33677, 33679, 33680, 33676, 33678, 33683, 33682, 33685, 33684, 33686 },
			[L["Warrior Set"]] = { 33730, 33732, 33728, 33729, 33731 },
			[L["Weapons"]] = { 33737, 33705, 34016, 33763, 33754, 33801, 33756, 33762, 33734, 33688, 33669, 34015, 33689, 33670, 34014, 33687, 33743, 33733, 33662, 33663, 33727, 34540, 33716, 33766, 33661, 33735, 33755, 33765, 34529, 33006, 34530, 34059, 34066, 33764, 33681, 34033, 33736, 33947, 33944, 33841, 33938, 33842, 33950, 33941, 33953, 33843 }
		},
		[format(L["Arena Season %d"], 4)] = {
			[L["Druid Set"]] = { 34999, 35001, 35002, 34998, 35000, 35112, 35114, 35115, 35111, 35113, 35023, 35025, 35026, 35022, 35024 },
			[L["Hunter Set"]] = { 34992, 34994, 34990, 34991, 34993 },
			[L["Mage Set"]] = { 35097, 35096, 35099, 35098, 35100 },
			[L["Paladin Set"]] = { 35029, 35031, 35027, 5028, 35030, 35090, 35092, 35088, 35089, 35091, 35061, 35063, 35059, 35060, 35062 },
			[L["Priest Set"]] = { 35084, 35086, 35087, 35083, 35085, 35054, 35056, 35057, 35053, 35055 },
			[L["Rogue Set"]] = {	35033, 35035, 35036, 35032, 35034 },
			[L["Shaman Set"]] = { 35044, 35046, 35042, 35043, 35045, 35050, 35052, 35048, 35049, 35051, 35079, 35081, 35077, 35078, 35080 },
			[L["Warlock Set"]] = { 35004, 35006, 35007, 35003, 35005, 35010, 35009, 35012, 35011, 35013 },
			[L["Warrior Set"]] = { 35068, 35070, 35066, 35067, 35069 },
			[L["Weapons"]] = { 35076, 35038, 35037, 35102, 37739, 35093, 35058, 35095, 35101, 35072, 35015, 34996, 34995, 35017, 34997, 35110, 35014, 35082, 37740, 35071, 34988, 34989, 35064, 34987, 35103, 35109, 34986, 35073, 35094, 35108, 35047, 35018, 35075, 34985, 35065, 35107, 35008, 35016, 35074, 35019, 35020, 35021, 35039, 35040, 35041, 35104, 35105, 35106 }
		},
		[format(L["Arena Season %d"], 5) ..format(" (%s)", ITEM_QUALITY3_DESC) ] = { 	-- Season 5 	Savage Gladiator
			[L["Death Knight Set"]] = {
				40817, 40857, 40837, 40799, 40779, 	-- deathknight	(Gladiator's Desecration)
			},
			[L["Druid Set"]] = {
				41324, 41278, 41301, 41290, 41313, 	-- druid	(Gladiator's Wildhide)
				41269, 41271, 41270, 41268, 41272, 	-- druid	(Gladiator's Refuge)
				41675, 41712, 41664, 41770, 41658, 	-- druid	(Gladiator's Sanctuary)
			},
			[L["Hunter Set"]] = {
				41154, 41214, 41202, 41140, 41084, 	-- hunter	(Gladiator's Pursuit)
			},
			[L["Mage Set"]] = {
				41943, 41962, 41956, 41968, 41949, 	-- mage	(Gladiator's Regalia)
			},
			[L["Paladin Set"]] = {
				40930, 40960, 40936, 40918, 40898, 	-- paladin	(Gladiator's Redemption)
				40818, 40858, 40838, 40798, 40780, 	-- paladin	(Gladiator's Vindication)
			},
			[L["Priest Set"]] = {
				41848, 41850, 41849, 41847, 41851, 	-- priest	(Gladiator's Investiture)
				41912, 41930, 41924, 41937, 41918, 	-- priest	(Gladiator's Raiment)
			},
			[L["Rogue Set"]] = {
				41644, 41646, 41645, 41643, 41647, 	-- rogue	(Gladiator's Vestments)
			},
			[L["Shaman Set"]] = {
				41148, 41208, 41160, 41134, 41078, 	-- shaman	(Gladiator's Earthshaker)
				41016, 41041, 41030, 41004, 40987, 	-- shaman	(Gladiator's Thunderfist)
				41010, 41024, 41023, 40998, 40986, 	-- shaman	(Gladiator's Wartide)
			},
			[L["Warlock Set"]] = {
				41990, 42008, 42002, 42014, 41996, 	-- warlock	(Gladiator's Felshroud)
			},
			[L["Warrior Set"]] = {
				40816, 40856, 40836, 40797, 40778, 	-- warrior	(Gladiator's Battlegear)
			},
			[L["Weapons"]] = {
				42206, 	-- Savage Gladiator's Cleaver	(One-Handed Axe)
				42212, 	-- Savage Gladiator's Chopper	(One-Handed Axe)
				42213, 	-- Savage Gladiator's Hacker	(One-Handed Axe)
				42214, 	-- Savage Gladiator's Waraxe (Hunter)	(One-Handed Axe)
				42215, 	-- Savage Gladiator's Mutilator	(Dagger)
				42216, 	-- Savage Gladiator's Shanker	(Dagger)
				42217, 	-- Savage Gladiator's Shiv	(Dagger)
				42218, 	-- Savage Gladiator's Right Ripper	(Fist Weapon)
				42219, 	-- Savage Gladiator's Left Render	(Fist Weapon)
				42220, 	-- Savage Gladiator's Left Ripper	(Fist Weapon)
				42221, 	-- Savage Gladiator's Bonecracker	(One-Handed Mace)
				42222, 	-- Savage Gladiator's Pummeler	(One-Handed Mace)
				42223, 	-- Savage Gladiator's Quickblade	(One-Handed Sword)
				42224, 	-- Savage Gladiator's Slicer	(One-Handed Sword)
				42294, 	-- Savage Gladiator's Decapitator	(Two-Handed Axe)
				42295, 	-- Savage Gladiator's Bonegrinder	(Two-Handed Mace)
				42296, 	-- Savage Gladiator's Pike	(Polearm)
				42297, 	-- Savage Gladiator's Greatsword	(Two-Handed Sword)
				42343, 	-- Savage Gladiator's Spellblade	(Dagger)
				42344, 	-- Savage Gladiator's Gavel	(One-Handed Mace)
				42356, 	-- Savage Gladiator's Battle Staff	(Staff)
				42382, 	-- Savage Gladiator's Energy Staff	(Staff)
				42388, 	-- Savage Gladiator's Staff (Druid)	(Staff)
				42444, 	-- Savage Gladiator's War Edge	(Thrown)
				42445, 	-- Savage Gladiator's Longbow	(Bow)
				42446, 	-- Savage Gladiator's Heavy Crossbow	(Crossbow)
				42447, 	-- Savage Gladiator's Rifle	(Gun)
				42448, 	-- Savage Gladiator's Touch of Defeat	(Wand)
				42511, 	-- Savage Gladiator's Baton of Light	(Wand)
				42517, 	-- Savage Gladiator's Piercing Touch	(Wand)
				42523, 	-- Savage Gladiator's Endgame	(Off-hand Frill)
				42529, 	-- Savage Gladiator's Reprieve	(Off-hand Frill)
				42535, 	-- Savage Gladiator's Grimoire	(Off-hand Frill)
				42556, 	-- Savage Gladiator's Shield Wall	(Shield)
				42557, 	-- Savage Gladiator's Barrier	(Shield)
				42568, 	-- Savage Gladiator's Redoubt	(Shield)
				42574, 	-- Savage Gladiator's Idol of Resolve	(Idol)
				42575, 	-- Savage Gladiator's Idol of Steadfastness	(Idol)
				42576, 	-- Savage Gladiator's Idol of Tenacity	(Idol)
				42593, 	-- Savage Gladiator's Totem of Indomitability	(Totem)
				42594, 	-- Savage Gladiator's Totem of Survival	(Totem)
				42595, 	-- Savage Gladiator's Totem of the Third Wind	(Totem)
				42611, 	-- Savage Gladiator's Libram of Fortitude	(Libram)
				42612, 	-- Savage Gladiator's Libram of Justice	(Libram)
				42618, 	-- Savage Gladiator's Sigil of Strife	(Sigil)
				44415, 	-- Savage Gladiator's War Staff	(Staff)
				44416, 	-- Savage Gladiator's Focus Staff	(Staff)
			},
		},
		[format(L["Arena Season %d"], 5) .." (200)" ] = { 	-- Season 5 	Hateful Gladiator
			[L["Death Knight Set"]] = {
				40820, 40860, 40841, 40803, 40781, 	-- deathknight (Gladiator's Desecration)
			},
			[L["Druid Set"]] = {
				41319, 41273, 41296, 41284, 41308, 	-- druid (Gladiator's Refuge)
				41676, 41713, 41665, 41771, 41659, 	-- druid (Gladiator's Sanctuary)
				41325, 41279, 41302, 41291, 41314, 	-- druid (Gladiator's Wildhide)
			},
			[L["Hunter Set"]] = {
				41155, 41215, 41203, 41141, 41085, 	-- hunter (Gladiator's Pursuit)
			},
			[L["Mage Set"]] = {
				41944, 41963, 41957, 41969, 41950, 	-- mage (Gladiator's Regalia)
			},
			[L["Paladin Set"]] = {
				40931, 40961, 40937, 40925, 40904, 	-- paladin (Gladiator's Redemption)
				40821, 40861, 40842, 40802, 40782, 	-- paladin (Gladiator's Vindication)
			},
			[L["Priest Set"]] = {
				41852, 41867, 41862, 41872, 41857, 	-- priest (Gladiator's Investiture)
				41913, 41931, 41925, 41938, 41919, 	-- priest (Gladiator's Raiment)
			},
			[L["Rogue Set"]] = {
				41670, 41681, 41653, 41765, 41648, 	-- rogue (Gladiator's Vestments)
			},
			[L["Shaman Set"]] = {
				41149, 41209, 41162, 41135, 41079, 	-- shaman (Gladiator's Earthshaker)
				41017, 41042, 41031, 41005, 40989, 	-- shaman (Gladiator's Thunderfist)
				41011, 41036, 41025, 40999, 40988, 	-- shaman (Gladiator's Wartide)
			},
			[L["Warlock Set"]] = {
				41991, 42009, 42003, 42015, 42001, 	-- warlock (Gladiator's Felshroud)
			},
			[L["Warrior Set"]] = {
				40819, 40859, 40840, 40801, 40783, 	-- warrior (Gladiator's Battlegear)
			},
			[L["Non Set Cloth"]] = {
				41877, 41878, 41879, 41896, 41901, 41907, 
			},
			[L["Non Set Leather"]] = {
				41330, 41331, 41332, 41628, 41633, 41638, 41827, 41828, 41830, 
			},
			[L["Non Set Mail"]] = { 
				41047, 41049, 41050, 41063, 41068, 41073, 41223, 41228, 41233, 
			},
			[L["Non Set Plate"]] = {
				40877, 40878, 40887, 40966, 40972, 40973, 
			},
			[L["Non Set Accessories"]] = {
				42020, 	-- Hateful Gladiator's Pendant of Triumph	(Amulet)
				42021, 	-- Hateful Gladiator's Pendant of Victory	(Amulet)
				42022, 	-- Hateful Gladiator's Pendant of Dominance	(Amulet)
				42023, 	-- Hateful Gladiator's Pendant of Subjugation	(Amulet)
				42024, 	-- Hateful Gladiator's Pendant of Ascendancy	(Amulet)
				42025, 	-- Hateful Gladiator's Pendant of Deliverance	(Amulet)
				42026, 	-- Hateful Gladiator's Pendant of Salvation	(Amulet)
				42055, 	-- Hateful Gladiator's Cloak of Dominance	(Cloak)
				42056, 	-- Hateful Gladiator's Cloak of Subjugation	(Cloak)
				42057, 	-- Hateful Gladiator's Cloak of Ascendancy	(Cloak)
				42058, 	-- Hateful Gladiator's Cloak of Salvation	(Cloak)
				42059, 	-- Hateful Gladiator's Cloak of Deliverance	(Cloak)
				42060, 	-- Hateful Gladiator's Cloak of Triumph	(Cloak)
				42061, 	-- Hateful Gladiator's Cloak of Victory	(Cloak)
				42110, 	-- Hateful Gladiator's Band of Dominance	(Ring)
				42112, 	-- Hateful Gladiator's Band of Triumph	(Ring)
			},
			[L["Weapons"]] = {
				42207, 	-- Hateful Gladiator's Cleaver	(One-Handed Axe)
				42226, 	-- Hateful Gladiator's Hacker	(One-Handed Axe)
				42231, 	-- Hateful Gladiator's Chopper	(One-Handed Axe)
				42236, 	-- Hateful Gladiator's Waraxe (Hunter)	(One-Handed Axe)
				42241, 	-- Hateful Gladiator's Shanker	(Dagger)
				42247, 	-- Hateful Gladiator's Shiv	(Dagger)
				42254, 	-- Hateful Gladiator's Mutilator	(Dagger)
				42259, 	-- Hateful Gladiator's Right Ripper	(Fist Weapon)
				42264, 	-- Hateful Gladiator's Left Render	(Fist Weapon)
				42269, 	-- Hateful Gladiator's Left Ripper	(Fist Weapon)
				42274, 	-- Hateful Gladiator's Pummeler	(One-Handed Mace)
				42279, 	-- Hateful Gladiator's Bonecracker	(One-Handed Mace)
				42284, 	-- Hateful Gladiator's Slicer	(One-Handed Sword)
				42289, 	-- Hateful Gladiator's Quickblade	(One-Handed Sword)
				42316, 	-- Hateful Gladiator's Decapitator	(Two-Handed Axe)
				42321, 	-- Hateful Gladiator's Bonegrinder	(Two-Handed Mace)
				42326, 	-- Hateful Gladiator's Pike	(Polearm)
				42331, 	-- Hateful Gladiator's Greatsword	(Two-Handed Sword)
				42345, 	-- Hateful Gladiator's Spellblade	(Dagger)
				42351, 	-- Hateful Gladiator's Gavel	(One-Handed Mace)
				42359, 	-- Hateful Gladiator's Battle Staff	(Staff)
				42383, 	-- Hateful Gladiator's Energy Staff	(Staff)
				42389, 	-- Hateful Gladiator's Staff (Druid)	(Staff)
				42449, 	-- Hateful Gladiator's War Edge	(Thrown)
				42484, 	-- Hateful Gladiator's Rifle	(Gun)
				42489, 	-- Hateful Gladiator's Longbow	(Bow)
				42494, 	-- Hateful Gladiator's Heavy Crossbow	(Crossbow)
				42501, 	-- Hateful Gladiator's Touch of Defeat	(Wand)
				42512, 	-- Hateful Gladiator's Baton of Light	(Wand)
				42518, 	-- Hateful Gladiator's Piercing Touch	(Wand)
				42524, 	-- Hateful Gladiator's Endgame	(Off-hand Frill)
				42530, 	-- Hateful Gladiator's Reprieve	(Off-hand Frill)
				42536, 	-- Hateful Gladiator's Grimoire	(Off-hand Frill)
				42558, 	-- Hateful Gladiator's Shield Wall	(Shield)
				42563, 	-- Hateful Gladiator's Barrier	(Shield)
				42569, 	-- Hateful Gladiator's Redoubt	(Shield)
				42577, 	-- Hateful Gladiator's Idol of Tenacity	(Idol)
				42582, 	-- Hateful Gladiator's Idol of Steadfastness	(Idol)
				42587, 	-- Hateful Gladiator's Idol of Resolve	(Idol)
				42596, 	-- Hateful Gladiator's Totem of the Third Wind	(Totem)
				42601, 	-- Hateful Gladiator's Totem of Survival	(Totem)
				42606, 	-- Hateful Gladiator's Totem of Indomitability	(Totem)
				42613, 	-- Hateful Gladiator's Libram of Justice	(Libram)
				42619, 	-- Hateful Gladiator's Sigil of Strife	(Sigil)
				42851, 	-- Hateful Gladiator's Libram of Fortitude	(Libram)
				44417, 	-- Hateful Gladiator's War Staff	(Staff)
				44418, 	-- Hateful Gladiator's Focus Staff	(Staff)
			},
		},
		[format(L["Arena Season %d"], 5)] = { 	-- Season 5 	Deadly Gladiator
			[L["Death Knight Set"]] = {
				40824, 40863, 40845, 40806, 40784, 	-- deathknight	(Gladiator's Desecration)
			},
			[L["Druid Set"]] = {
				41320, 41274, 41297, 41286, 41309, 	-- druid	(Gladiator's Refuge)
				41677, 41714, 41666, 41772, 41660, 	-- druid	(Gladiator's Sanctuary)
				41326, 41280, 41303, 41292, 41315, 	-- druid	(Gladiator's Wildhide)
			},
			[L["Hunter Set"]] = {
				41156, 41216, 41204, 41142, 41086, 	-- hunter	(Gladiator's Pursuit)
			},
			[L["Mage Set"]] = {
				41945, 41964, 41958, 41970, 41951, 	-- mage	(Gladiator's Regalia)
			},
			[L["Paladin Set"]] = {
				40932, 40962, 40938, 40926, 40905, 	-- paladin	(Gladiator's Redemption)
				40825, 40864, 40846, 40805, 40785, 	-- paladin	(Gladiator's Vindication)
			},
			[L["Priest Set"]] = {
				41853, 41868, 41863, 41873, 41858, 	-- priest	(Gladiator's Investiture)
				41914, 41933, 41926, 41939, 41920, 	-- priest	(Gladiator's Raiment)
			},
			[L["Rogue Set"]] = {
				41671, 41682, 41654, 41766, 41649, 	-- rogue	(Gladiator's Vestments)
			},
			[L["Shaman Set"]] = {
				41150, 41210, 41198, 41136, 41080, 	-- shaman	(Gladiator's Earthshaker)
				41018, 41043, 41032, 41006, 40991, 	-- shaman	(Gladiator's Thunderfist)
				41012, 41037, 41026, 41000, 40990, 	-- shaman	(Gladiator's Wartide)
			},
			[L["Warlock Set"]] = {
				41992, 42010, 42004, 42016, 41997, 	-- warlock	(Gladiator's Felshroud)
			},
			[L["Warrior Set"]] = {
				40823, 40862, 40844, 40804, 40786, 	-- warrior	(Gladiator's Battlegear)
			},
			[L["Non Set Cloth"]] = {
				41880, 41884, 41892, 41897, 41902, 41908, 
			},
			[L["Non Set Leather"]] = {
				41616, 41620, 41624, 41629, 41634, 41639, 41831, 41835, 41839, 
			},
			[L["Non Set Mail"]] = {
				41048, 41054, 41059, 41064, 41069, 41074, 41224, 41229, 41234, 
			},
			[L["Non Set Plate"]] = {
				40879, 40880, 40888, 40974, 40975, 40982, 
			},
			[L["Non Set Accessories"]] = {
				42027, 	-- Deadly Gladiator's Pendant of Triumph (Amulet)
				42028, 	-- Deadly Gladiator's Pendant of Victory (Amulet)
				42029, 	-- Deadly Gladiator's Pendant of Dominance (Amulet)
				42030, 	-- Deadly Gladiator's Pendant of Ascendancy (Amulet)
				42031, 	-- Deadly Gladiator's Pendant of Subjugation (Amulet)
				42032, 	-- Deadly Gladiator's Pendant of Deliverance (Amulet)
				42033, 	-- Deadly Gladiator's Pendant of Salvation (Amulet)
				42062, 	-- Deadly Gladiator's Cloak of Dominance (Cloak)
				42063, 	-- Deadly Gladiator's Cloak of Subjugation (Cloak)
				42064, 	-- Deadly Gladiator's Cloak of Ascendancy (Cloak)
				42065, 	-- Deadly Gladiator's Cloak of Salvation (Cloak)
				42066, 	-- Deadly Gladiator's Cloak of Deliverance (Cloak)
				42067, 	-- Deadly Gladiator's Cloak of Triumph (Cloak)
				42068, 	-- Deadly Gladiator's Cloak of Victory (Cloak)
				42114, 	-- Deadly Gladiator's Band of Ascendancy (Ring)
				42115, 	-- Deadly Gladiator's Band of Victory (Ring)
				42122, 	-- Medallion of the Horde (Trinket)
				42123, 	-- Medallion of the Alliance (Trinket)
				42128, 	-- Battlemaster's Hostility (Trinket)
				42129, 	-- Battlemaster's Accuracy (Trinket)
				42130, 	-- Battlemaster's Avidity (Trinket)
				42131, 	-- Battlemaster's Conviction (Trinket)
				42132, 	-- Battlemaster's Bravery (Trinket)
			},
			[L["Weapons"]] = {
				42208, 	-- Deadly Gladiator's Cleaver (One-Handed Axe)
				42227, 	-- Deadly Gladiator's Hacker (One-Handed Axe)
				42232, 	-- Deadly Gladiator's Chopper (One-Handed Axe)
				42237, 	-- Deadly Gladiator's Waraxe (Hunter) (One-Handed Axe)
				42242, 	-- Deadly Gladiator's Shanker (Dagger)
				42248, 	-- Deadly Gladiator's Shiv (Dagger)
				42255, 	-- Deadly Gladiator's Mutilator (Dagger)
				42260, 	-- Deadly Gladiator's Right Ripper (Fist Weapon)
				42265, 	-- Deadly Gladiator's Left Render (Fist Weapon)
				42270, 	-- Deadly Gladiator's Left Ripper (Fist Weapon)
				42275, 	-- Deadly Gladiator's Pummeler (One-Handed Mace)
				42280, 	-- Deadly Gladiator's Bonecracker (One-Handed Mace)
				42285, 	-- Deadly Gladiator's Slicer (One-Handed Sword)
				42290, 	-- Deadly Gladiator's Quickblade (One-Handed Sword)
				42317, 	-- Deadly Gladiator's Decapitator (Two-Handed Axe)
				42322, 	-- Deadly Gladiator's Bonegrinder (Two-Handed Mace)
				42327, 	-- Deadly Gladiator's Pike (Polearm)
				42332, 	-- Deadly Gladiator's Greatsword (Two-Handed Sword)
				42346, 	-- Deadly Gladiator's Spellblade (Dagger)
				42352, 	-- Deadly Gladiator's Gavel (One-Handed Mace)
				42362, 	-- Deadly Gladiator's Battle Staff (Staff)
				42384, 	-- Deadly Gladiator's Energy Staff (Staff)
				42390, 	-- Deadly Gladiator's Staff (Druid) (Staff)
				42450, 	-- Deadly Gladiator's War Edge (Thrown)
				42485, 	-- Deadly Gladiator's Rifle (Gun)
				42490, 	-- Deadly Gladiator's Longbow (Bow)
				42495, 	-- Deadly Gladiator's Heavy Crossbow (Crossbow)
				42502, 	-- Deadly Gladiator's Touch of Defeat (Wand)
				42513, 	-- Deadly Gladiator's Baton of Light (Wand)
				42519, 	-- Deadly Gladiator's Piercing Touch (Wand)
				42525, 	-- Deadly Gladiator's Endgame (Off-hand Frill)
				42531, 	-- Deadly Gladiator's Reprieve (Off-hand Frill)
				42537, 	-- Deadly Gladiator's Grimoire (Off-hand Frill)
				42559, 	-- Deadly Gladiator's Shield Wall (Shield)
				42564, 	-- Deadly Gladiator's Barrier (Shield)
				42570, 	-- Deadly Gladiator's Redoubt (Shield)
				42578, 	-- Deadly Gladiator's Idol of Tenacity (Idol)
				42583, 	-- Deadly Gladiator's Idol of Steadfastness (Idol)
				42588, 	-- Deadly Gladiator's Idol of Resolve (Idol)
				42597, 	-- Deadly Gladiator's Totem of the Third Wind (Totem)
				42602, 	-- Deadly Gladiator's Totem of Survival (Totem)
				42607, 	-- Deadly Gladiator's Totem of Indomitability (Totem)
				42614, 	-- Deadly Gladiator's Libram of Justice (Libram)
				42620, 	-- Deadly Gladiator's Sigil of Strife (Sigil)
				42852, 	-- Deadly Gladiator's Libram of Fortitude (Libram)
				44419, 	-- Deadly Gladiator's War Staff (Staff)
				44420, 	-- Deadly Gladiator's Focus Staff (Staff)
			},
		},
		[format(L["Arena Season %d"], 6)] = {
			[L["Death Knight Set"]] = { 40827, 40868, 40787, 40809, 40848 },
			[L["Druid Set"]] = { 41327, 41281, 41316, 41293, 41304, 41678, 41715, 41661, 41773, 41667, 41321, 41275, 41310, 41287, 41298 },
			[L["Hunter Set"]] = { 41157, 41217, 41087, 41143, 41205 },
			[L["Mage Set"]] = { 41946, 41965, 41953, 41971, 41959 },
			[L["Paladin Set"]] = { 40828, 40869, 40788, 40808, 40849, 40933, 40963, 40907, 40927, 40939 },
			[L["Priest Set"]] = { 41915, 41934, 41921, 41940, 41927, 41854, 41869, 41859, 41874, 41864 },
			[L["Rogue Set"]] = {	41672, 41683, 41650, 41767, 41655 },
			[L["Shaman Set"]] = { 41019, 41044, 40993, 41007, 41033, 41151, 41211, 41081, 41137, 41199, 41013, 41038, 40992, 41001, 41027 },
			[L["Warlock Set"]] = { 41993, 42011, 41998, 42017, 42005 },
			[L["Warrior Set"]] = { 40826, 40866, 40789, 40807, 40847 },
		},
		[format(L["Arena Season %d"], 7)] = {
			[L["Death Knight Set"]] = { 40830, 40871, 40791, 40811, 40851 },
			[L["Druid Set"]] = { 41328, 41282, 41317, 41294, 41305, 41679, 41716, 41662, 41774, 41668, 41322, 41276, 41311, 41288, 41299 },
			[L["Hunter Set"]] = { 41158, 41218, 41088, 41144, 41206 },
			[L["Mage Set"]] = { 41947, 41966, 41954, 41972, 41960 },
			[L["Paladin Set"]] = { 40831, 40872, 40792, 40812, 40852, 40934, 40964, 40910, 40928, 40940 },
			[L["Priest Set"]] = { 41916, 41935, 41922, 41941, 41928, 41855, 41870, 41860, 41875, 41865 },
			[L["Rogue Set"]] = {	41673, 41684, 41651, 41768, 41656 },
			[L["Shaman Set"]] = { 41020, 41045, 40995, 41008, 41034, 41152, 41212, 41082, 41138, 41200, 41014, 41039, 40994, 41002, 41028 },
			[L["Warlock Set"]] = { 41994, 42012, 41999, 42018, 42006 },
			[L["Warrior Set"]] = { 40829, 40870, 40790, 40810, 40850 },
		},
		[format(L["Arena Season %d"], 8)] = { 	-- Season 8 	Wrathful Gladiator
			[L["Death Knight Set"]] = {
				51415, 51418, 51416, 51414, 51413, 	-- deathknight	(Entweihung des Gladiators)
			},
			[L["Druid Set"]] = {
				51421, 51424, 51422, 51420, 51419, 	-- druid	(Zuflucht des Gladiators)
				51427, 51430, 51428, 51426, 51425, 	-- druid	(Schutzgewandung des Gladiators)
				51435, 51438, 51436, 51434, 51433, 	-- druid	(Wildfell des Gladiators)
			},
			[L["Hunter Set"]] = {
				51460, 51462, 51461, 51459, 51458, 	-- hunter	(Jagdtracht des Gladiators)
			},
			[L["Mage Set"]] = {
				51465, 51467, 51466, 51464, 51463, 	-- mage	(Ornat des Gladiators)
			},
			[L["Paladin Set"]] = {
				51470, 51473, 51471, 51469, 51468, 	-- paladin	(Erlösung des Gladiators)
				51476, 51479, 51477, 51475, 51474, 	-- paladin	(Rechtschaffenheit des Gladiators)
			},
			[L["Priest Set"]] = {
				51484, 51486, 51485, 51483, 51482, 	-- priest	(Vereidigung des Gladiators)
				51489, 51491, 51490, 51488, 51487, 	-- priest	(Gewandung des Gladiators)
			},
			[L["Rogue Set"]] = {
				51494, 51496, 51495, 51493, 51492, 	-- rogue	(Gewänder des Gladiators)
			},
			[L["Shaman Set"]] = {
				51499, 51502, 51500, 51498, 51497, 	-- shaman	(Kriegsrausch des Gladiators)
				51505, 51508, 51506, 51504, 51503, 	-- shaman	(Erderschütterer des Gladiators)
				51511, 51514, 51512, 51510, 51509, 	-- shaman	(Donnerfaust des Gladiators)
			},
			[L["Warlock Set"]] = {
				51538, 51540, 51539, 51537, 51536, 	-- warlock	(Teufelsschleier des Gladiators)
			},
			[L["Warrior Set"]] = {
				51543, 51545, 51544, 51542, 51541, 	-- warrior	(Schlachtrüstung des Gladiators)
			},
			[L["Non Set Cloth"]] = {
				51327, 51328, 51329, 51337, 51338, 51339, 51365, 51366, 51367, 
			},
			[L["Non Set Leather"]] = {
				51340, 51341, 51342, 51343, 51344, 51345, 51368, 51369, 51370, 
			},
			[L["Non Set Mail"]] = {
				51350, 51351, 51352, 51371, 51372, 51373, 51374, 51375, 51376, 
			},
			[L["Non Set Plate"]] = {
				51359, 51360, 51361, 51362, 51363, 51364, 
			},
			[L["Non Set Accessories"]] = {
				51330, 	-- Wrathful Gladiator's Cloak of Dominance	(Cloak)
				51331, 	-- Wrathful Gladiator's Pendant of Dominance	(Amulet)
				51332, 	-- Wrathful Gladiator's Cloak of Subjugation	(Cloak)
				51333, 	-- Wrathful Gladiator's Pendant of Subjugation	(Amulet)
				51334, 	-- Wrathful Gladiator's Cloak of Ascendancy	(Cloak)
				51335, 	-- Wrathful Gladiator's Pendant of Ascendancy	(Amulet)
				51336, 	-- Wrathful Gladiator's Band of Dominance	(Ring)
				51346, 	-- Wrathful Gladiator's Cloak of Salvation	(Cloak)
				51347, 	-- Wrathful Gladiator's Pendant of Salvation	(Amulet)
				51348, 	-- Wrathful Gladiator's Cloak of Deliverance	(Cloak)
				51349, 	-- Wrathful Gladiator's Pendant of Deliverance	(Amulet)
				51353, 	-- Wrathful Gladiator's Pendant of Sundering	(Amulet)
				51354, 	-- Wrathful Gladiator's Cloak of Triumph	(Cloak)
				51355, 	-- Wrathful Gladiator's Pendant of Triumph	(Amulet)
				51356, 	-- Wrathful Gladiator's Cloak of Victory	(Cloak)
				51357, 	-- Wrathful Gladiator's Pendant of Victory	(Amulet)
				51358, 	-- Wrathful Gladiator's Band of Triumph	(Ring)
				51534, 	-- Wrathful Gladiator's Tabard	(Tabard)
				51377, 	-- Medallion of the Alliance
				51378, 	-- Medallion of the Horde
			},
			[ format("%s (270)", L["Weapons"]) ] = {
				51396, 	-- Wrathful Gladiator's Endgame	(Off-hand Frill)
				51407, 	-- Wrathful Gladiator's Compendium	(Off-hand Frill)
				51408, 	-- Wrathful Gladiator's Grimoire	(Off-hand Frill)
				51409, 	-- Wrathful Gladiator's Reprieve	(Off-hand Frill)
				51417, 	-- Wrathful Gladiator's Sigil of Strife	(Sigil)
				51423, 	-- Wrathful Gladiator's Idol of Tenacity	(Idol)
				51429, 	-- Wrathful Gladiator's Idol of Resolve	(Idol)
				51437, 	-- Wrathful Gladiator's Idol of Steadfastness	(Idol)
				51452, 	-- Wrathful Gladiator's Barrier	(Shield)
				51455, 	-- Wrathful Gladiator's Redoubt	(Shield)
				51472, 	-- Wrathful Gladiator's Libram of Justice	(Libram)
				51478, 	-- Wrathful Gladiator's Libram of Fortitude	(Libram)
				51501, 	-- Wrathful Gladiator's Totem of the Third Wind	(Totem)
				51507, 	-- Wrathful Gladiator's Totem of Indomitability	(Totem)
				51513, 	-- Wrathful Gladiator's Totem of Survival	(Totem)
				51533, 	-- Wrathful Gladiator's Shield Wall	(Shield)
			},
			[ format("%s (264)", L["Weapons"]) ] = {
				51388, 	-- Wrathful Gladiator's Decapitator	(Two-Handed Axe)
				51390, 	-- Wrathful Gladiator's Bonegrinder	(Two-Handed Mace)
				51392, 	-- Wrathful Gladiator's Greatsword	(Two-Handed Sword)
				51394, 	-- Wrathful Gladiator's Longbow	(Bow)
				51397, 	-- Wrathful Gladiator's Spellblade	(Dagger)
				51400, 	-- Wrathful Gladiator's War Staff	(Staff)
				51402, 	-- Wrathful Gladiator's Focus Staff	(Staff)
				51404, 	-- Wrathful Gladiator's Battle Staff	(Staff)
				51406, 	-- Wrathful Gladiator's Blade of Alacrity	(Dagger)
				51410, 	-- Wrathful Gladiator's Touch of Defeat	(Wand)
				51411, 	-- Wrathful Gladiator's Heavy Crossbow	(Crossbow)
				51431, 	-- Wrathful Gladiator's Staff (Druid)	(Staff)
				51439, 	-- Wrathful Gladiator's Hacker	(One-Handed Axe)
				51441, 	-- Wrathful Gladiator's Shiv	(Dagger)
				51443, 	-- Wrathful Gladiator's Left Ripper	(Fist Weapon)
				51445, 	-- Wrathful Gladiator's Bonecracker	(One-Handed Mace)
				51447, 	-- Wrathful Gladiator's Quickblade	(One-Handed Sword)
				51449, 	-- Wrathful Gladiator's Rifle	(Gun)
				51451, 	-- Wrathful Gladiator's Wand of Alacrity	(Wand)
				51453, 	-- Wrathful Gladiator's Gavel	(One-Handed Mace)
				51456, 	-- Wrathful Gladiator's Energy Staff	(Staff)
				51480, 	-- Wrathful Gladiator's Pike	(Polearm)
				51515, 	-- Wrathful Gladiator's Cleaver	(One-Handed Axe)
				51517, 	-- Wrathful Gladiator's Shanker	(Dagger)
				51519, 	-- Wrathful Gladiator's Pummeler	(One-Handed Mace)
				51521, 	-- Wrathful Gladiator's Slicer	(One-Handed Sword)
				51523, 	-- Wrathful Gladiator's Right Ripper	(Fist Weapon)
				51525, 	-- Wrathful Gladiator's Chopper	(One-Handed Axe)
				51527, 	-- Wrathful Gladiator's Mutilator	(Dagger)
				51530, 	-- Wrathful Gladiator's Left Render	(Fist Weapon)
				51531, 	-- Wrathful Gladiator's Piercing Touch	(Wand)
				51532, 	-- Wrathful Gladiator's Baton of Light	(Wand)
				51535, 	-- Wrathful Gladiator's War Edge	(Thrown)
			},
			[ format("%s (277)", L["Weapons"]) ] = {
				51389, 	-- Wrathful Gladiator's Sunderer (Two-Handed Axe)
				51391, 	-- Wrathful Gladiator's Crusher (Two-Handed Mace)
				51393, 	-- Wrathful Gladiator's Claymore (Two-Handed Sword)
				51395, 	-- Wrathful Gladiator's Recurve (Bow)
				51398, 	-- Wrathful Gladiator's Blade of Celerity (Dagger)
				51399, 	-- Wrathful Gladiator's Mageblade (Dagger)
				51401, 	-- Wrathful Gladiator's Combat Staff (Staff)
				51403, 	-- Wrathful Gladiator's Acute Staff (Staff)
				51405, 	-- Wrathful Gladiator's Skirmish Staff (Staff)
				51412, 	-- Wrathful Gladiator's Repeater (Crossbow)
				51432, 	-- Wrathful Gladiator's Greatstaff (Druid) (Staff)
				51440, 	-- Wrathful Gladiator's Dicer (One-Handed Axe)
				51442, 	-- Wrathful Gladiator's Dirk (Dagger)
				51444, 	-- Wrathful Gladiator's Left Razor (Fist Weapon)
				51446, 	-- Wrathful Gladiator's Punisher (One-Handed Mace)
				51448, 	-- Wrathful Gladiator's Swiftblade (One-Handed Sword)
				51450, 	-- Wrathful Gladiator's Shotgun (Gun)
				51454, 	-- Wrathful Gladiator's Salvation (One-Handed Mace)
				51457, 	-- Wrathful Gladiator's Light Staff (Staff)
				51481, 	-- Wrathful Gladiator's Halberd (Polearm)
				51516, 	-- Wrathful Gladiator's Handaxe (One-Handed Axe)
				51518, 	-- Wrathful Gladiator's Spike (Dagger)
				51520, 	-- Wrathful Gladiator's Truncheon (One-Handed Mace)
				51522, 	-- Wrathful Gladiator's Longblade (One-Handed Sword)
				51524, 	-- Wrathful Gladiator's Grasp (Fist Weapon)
				51526, 	-- Wrathful Gladiator's Splitter (One-Handed Axe)
				51528, 	-- Wrathful Gladiator's Eviscerator (Dagger)
				51529, 	-- Wrathful Gladiator's Left Claw (Fist Weapon)
			},
		},
		
		[format(L["Level %d Honor PVP"], 60)] = {	
			[BI["Druid"]] = { 16451, 16449, 16452, 16448, 16450, 16459, 23308, 23309, 23294, 23280, 23295, 23281, 16550, 16551, 16549, 16555, 16552, 16554, 23253, 23254, 22877, 22863, 22878, 22852 },
			[BI["Hunter"]] = { 16465, 16468, 16466, 16463, 16467, 16462, 23306, 23307, 23292, 23279, 23293, 23278, 16566, 16568, 16565, 16571, 16567, 16569, 23251, 23252, 22874, 22862, 22875, 22843 },
			[BI["Mage"]] = { 16441, 16444, 16443, 16440, 16442, 16437, 23318, 23319, 23305, 23290, 23304, 23291, 16533, 16536, 16535, 16540, 16534, 16539, 23263, 23264, 22886, 22870, 22883, 22860 },
			[BI["Paladin"]] = { 16474, 16476, 16473, 16471, 16475, 16472, 23276, 23277, 23272, 23274, 23273, 23275, 29616, 29617, 29615, 29613, 29614, 29612, 29604, 29605, 29602, 29600, 29603, 29601 },
			[BI["Priest"]] = { 17602, 17604, 17605, 17608, 17603, 17607, 23316, 23317, 23303, 23288, 23302, 23289, 17623, 17622, 17624, 17620, 17625, 17618, 23261, 23262, 22885, 22869, 22882, 22859 },
			[BI["Rogue"]] = {	16455, 16457, 16453, 16454, 16456, 16446, 23312, 23313, 23298, 23284, 23299, 23285, 16561, 16562, 16563, 16560, 16564, 16558, 23257, 23258, 22879, 22864, 22880, 22856 },
			[BI["Shaman"]] = { 29610, 29611, 29609, 29607, 29608, 29606, 29598, 29599, 29596, 29595, 29597, 29594, 16578, 16580, 16577, 16574, 16579, 16573, 23259, 23260, 22876, 22867, 22887, 22857 },
			[BI["Warlock"]] = { 17578, 17580, 17581, 17584, 17579, 17583, 23310, 23311, 23297, 23282, 23296, 23283, 17591, 17590, 17592, 17588, 17593, 17586, 23255, 23256, 22884, 22865, 22881, 22855 },
			[BI["Warrior"]] = { 16478, 16480, 16477, 16484, 16479, 16483, 23314, 23315, 23300, 23286, 23301, 23287, 16542, 16544, 16541, 16548, 16543, 16545, 23244, 23243, 22872, 22868, 22873, 22858 },
			[L["Weapons"] .. " (" .. FACTION_ALLIANCE .. ")"] = { 18843, 18847, 23451, 18838, 12584, 23456, 18876, 18827, 18830, 23454, 18865, 18867, 23455, 18869, 18873, 18825, 18833, 18836, 18855, 23452, 23453 },
			[L["Weapons"] .. " (" .. FACTION_HORDE .. ")"] = { 18844, 18848, 23466, 18840, 16345, 23467, 18877, 18828, 18831, 23464, 18866, 18868, 23465, 18871, 18874, 18826, 18835, 18837, 18860, 23468, 23469 },
			[L["Accessories"] .. " (" .. FACTION_ALLIANCE .. ")"] = { 29465, 29467, 29468, 29471, 35906, 18863, 18856, 18859, 18864, 18862, 18857, 29593, 18858, 18854, 18440, 18441, 16342, 18457, 18456, 18455, 18454, 18453, 18452, 18449, 18448, 18447, 18445, 18442, 18444, 18443, 15196, 15198, 18606, },
			[L["Accessories"] .. " (" .. FACTION_HORDE .. ")"] = { 29466, 29469, 29470, 29472, 34129, 18853, 18846, 18850, 29592, 18851, 18849, 18845, 18852, 18834, 18427, 16341, 18461, 18437, 16486, 18436, 18434, 18435, 16497, 18432, 16532, 18430, 18429, 15200, 18428, 16335, 15197, 15199, 18607, },
			[L["Accessories"]] = { 18839, 18841, 32455 },
			[L["Miscellaneous"]] = { 17348, 17349, 17351, 17352, },
		},
		[L["Level 70 Reputation PVP"]] = {	
			[BI["Druid"]] = { 35357, 35359, 35360, 35356, 35358, 35372, 35374, 35375, 35371, 35373, 35362, 35364, 35365, 35361, 35363, 35469, 35470, 35471 },
			[BI["Hunter"]] = { 35378, 35380, 35376, 35377, 35379, 35475 },
			[BI["Mage"]] = { 35344, 35343, 35346, 35345, 35347, 35465 },
			[BI["Paladin"]] = { 35414, 35416, 35412, 35413, 35415, 35404, 35406, 35402, 35403, 35405, 35476, 35477 },
			[BI["Priest"]] = { 35339, 35341, 35342, 35338, 35340, 35333, 35336, 35337, 35335, 35334, 35467, 35466 },
			[BI["Rogue"]] = {	35367, 35369, 35370, 35366, 35368, 35468 },
			[BI["Shaman"]] = { 35383, 35385, 35381, 35382, 35384, 35388, 35390, 35386, 35387, 35389, 35393, 35395, 35391, 35392, 35394, 35472, 35473, 35474 },
			[BI["Warlock"]] = { 35329, 35331, 35332, 35328, 35330, 35464 },
			[BI["Warrior"]] = { 35409, 35411, 35407, 35408, 35410, 35478 },
		},
		[format(L["Level %d Honor PVP"], 70)] = {	
			[L["Weapons"] .. " (" .. FACTION_ALLIANCE .. ")"] = { 28953, 28947, 28957, 28954, 28955, 28956, 28952, 28943, 28944, 28946, 28945, 28950, 28951, 28942, 28948, 28949, 28959, 28940, 28960, 28941	},
			[L["Weapons"] .. " (" .. FACTION_HORDE .. ")"] = {	28928, 28922, 28931, 28929, 28930, 28937, 28926, 28293, 28920, 28921, 28918, 28924, 28925, 28917, 28919, 28923, 28935, 28939, 28933, 28938 },
			[L["Accessories"] .. " (" .. FACTION_ALLIANCE .. ")"] = { 25829, 28235, 28237, 28238, 28236, 30349, 28234, 30351, 30348, 30350,  },
			[L["Accessories"] .. " (" .. FACTION_HORDE .. ")"] = { 24551, 28241, 28243, 28239, 28242, 30346, 28240, 30345, 30343, 30344, },
			[L["Accessories"]] = { 28246, 28247, 28362, 28119, 28363, 31853, 31839, 31855, 31841, 32453, 28118, 28120, 28123, 31838, 31852, 31840, 31854 },
			[L["Non Set Accessories"]] = { 28378, 28377, 33920, 33921, 33922, 35317, 35319, 33923, 33056, 33064, 33057, 34576, 34577, 34578, 34579, 34580, 33853, 33918, 35320, 33919 },
			[L["Non Set Cloth"]] = { 33883, 33882, 33884, 33901, 33900, 33902, 33913, 33912, 33914 },
			[L["Non Set Leather"]] = {	33881, 33879, 33880, 33887, 33885, 33886, 33893, 33891, 33892, 33917, 33915, 33916 },
			[L["Non Set Mail"]] = {	33876, 33877, 33878, 33894, 33895, 33896, 33897, 33898, 33899, 33906, 33907, 33908 },
			[L["Non Set Plate"]] = { 33889, 33888, 33890, 33904, 33903, 33905, 33813, 33811, 33812, 33910, 33909, 33911 }
		},
		[format(L["Level %d Honor PVP"], 80)] = {	
			[L["Non Set Accessories"]] = { 42020, 42021, 42022, 42023, 42024, 42025, 42026, 42110, 42112, 42055, 42056, 42057, 42058,	42059, 42060, 42061, 42122, 42123, 42128, 42129, 42130, 42131, 42132 },
			[L["Non Set Cloth"]] = { 41907, 41896, 41901, 41878, 41877, 41879, 41908, 41897,	41902, 41892, 41880, 41884 },
			[L["Non Set Leather"]] = {	41638, 41628, 41633, 41332, 41330, 41331, 41830, 41827, 41828, 41639, 41629, 41634, 41624,	41616, 41620, 41839, 41831, 41835 },
			[L["Non Set Mail"]] = {	41063, 41068, 41073, 41047, 41050, 41049, 41223, 41233,	41228, 41064, 41069, 41074, 41059,	41048, 41054, 41224, 41234, 41229 },
			[L["Non Set Plate"]] = { 40972, 40966, 40973, 40887, 40877, 40878, 40982, 40974,	40975, 40888, 40879, 40880 },
			[L["Savage Gladiator\'s Weapons"]] = { 42294, 42295, 42297, 42445, 42343, 42356, 42448, 42446, 42213, 42217, 42220, 42221, 42223, 42447, 42557, 42568, 42344, 42296, 42206, 42216, 42222, 42224, 42218, 42212, 42214, 42219, 42517, 42511, 42556, 42444, 42618, 42574, 42575, 42576, 42612, 42611, 42595, 42593, 42594	},
			[L["Deadly Gladiator\'s Weapons"]] = {	42317, 42322, 42332, 42346, 42454, 42227, 42248, 42270, 42280, 42290, 42352, 42327, 42208, 42242, 42275, 42285, 42260, 42232, 42237, 42265, 42362, 42384, 44420, 44419, 42564, 42570, 42559, 42450, 42490, 42495, 42485, 42513, 42519, 42502, 42525, 42537, 42531, 42588, 42583, 42578, 42614, 42852, 42620, 42597, 42607, 42602 },
			[BZ["Wintergrasp"]] = { 43956, 44077, 44066, 44075, 44069, 44068, 44067, 44081, 44084, 44082, 44076, 44078, 44087, 44088, 44089, 41730, 41732, 41733, 41735, 41739, 41736, 41738, 41734, 41727, 41740, 41728, 41742, 41743, 41744, 44107, 44103, 44105, 44102, 44101, 44100, 44099, 44098, 44097, 44091, 44096, 44092, 44094, 44095, 44093, 44115, 44910, 44909, 44899, 44900, 44907, 44906, 44908, 44891, 44892, 44893, 44914, 44912, 44903, 44904, 44905, 44896, 44897, 44898, 44901, 44902, 44894, 44895, },
			[BZ["Grizzly Hills"]] = { 38354, 38355, 38353, 38358, 38359, 38357, 38356, 38360, 38365, 38366, 38364, 38363, 38362, 37836, 38368, 38367, 38361, 40875, 40822, 40867 },
		},
		
		-- Tier 0 (dungeon 1) is already in the level 60 instances (strat, scholo ..)
		[L["Tier 0.5 Quests"]] = { 
			[BI["Druid"]] = { 22109, 22112, 22113, 22108, 22110, 22106, 22111, 22107 },
			[BI["Hunter"]] = { 22013, 22016, 22060, 22011, 22015, 22010, 22017, 22061 },
			[BI["Mage"]] = { 22065, 22068, 22069, 22063, 22066, 22062, 22067, 22064 },
			[BI["Paladin"]] = { 22091, 22093, 22089, 22088, 22090, 22086, 22092, 22087 },
			[BI["Priest"]] = { 22080, 22082, 22083, 22079, 22081, 22078, 22085, 22084 },
			[BI["Rogue"]] = { 22005, 22008, 22009, 22004, 22006, 22002, 22007, 22003 },
			[BI["Shaman"]] = { 22097, 22101, 22102, 22095, 22099, 22098, 22100, 22096 },
			[BI["Warlock"]] = { 22074, 22073, 22075, 22071, 22077, 22070, 22072, 22076 },
			[BI["Warrior"]] = { 21999, 22001, 21997, 21996, 21998, 21994, 22000, 21995 }
		},	
		-- Dungeon 3 (level 70) is already in the BC 5-men
		
		-- Tier 1 is already in MC
		-- Tier 2 is already in BWL, Ony
		
		[format(L["Tier %d Tokens"], 3)] = {
			[BI["Druid"]] = { 22490, 22491, 22488, 22495, 22493, 22494, 22489, 22492, 23064 },
			[BI["Hunter"]] = { 22438, 22439, 22436, 22443, 22441, 22442, 22437, 22440, 23067 },
			[BI["Mage"]] = { 22498, 22499, 22496, 22503, 22501, 22502, 22497, 22500, 23062 },
			[BI["Paladin"]] = { 22428, 22429, 22425, 22424, 22426, 22431, 22427, 22430, 23066 },
			[BI["Priest"]] = { 22514, 22515, 22512, 22519, 22517, 22518, 22513, 22516, 23061 },
			[BI["Rogue"]] = { 22478, 22479, 22476, 22483, 22481, 22482, 22477, 22480, 23060 },
			[BI["Shaman"]] = { 22466, 22467, 22464, 22471, 22469, 22470, 22465, 22468, 23065 },
			[BI["Warlock"]] = { 22506, 22507, 22504, 22511, 22509, 22510, 22505, 22508, 23063 },
			[BI["Warrior"]] = { 22418, 22419, 22416, 22423, 22421, 22422, 22417, 22420, 23059 }
		},
		[format(L["Tier %d Tokens"], 4)] = {
			[BB["Prince Malchezaar"] .. " (" .. BZ["Karazhan"] .. ")"] = { 29098, 29086, 29093, 29081, 29076, 29068, 29073, 29061, 29049, 29058, 29044, 29040, 29028, 29035, 28963, 29011, 29021 },		-- T4 helm
			[BB["High King Maulgar"] .. " (" .. BZ["Gruul's Lair"] .. ")"] = { 29100, 29089, 29095, 29084, 29079, 29070, 29075, 29064, 29054, 29060, 29047, 29043, 29031, 29037, 28967, 29016, 29023 },		-- T4 shoulder
			[BB["Magtheridon"] .. " (" .. BZ["Magtheridon's Lair"] .. ")"] = { 29096, 29087, 29091, 29082, 29077, 29066, 29071, 29062, 29050, 29056, 29045, 29038, 29029, 29033, 28964, 29012, 29019 },		-- T4 chest
			[BB["The Curator"] .. " (" .. BZ["Karazhan"] .. ")"] = { 29097, 29090, 29092, 29085, 29080, 29067, 29072, 29065, 29055, 29057, 29048, 29039, 29032, 29034, 28968, 29017, 29020 },		-- T4 gloves
			[BB["Gruul the Dragonkiller"] .. " (" .. BZ["Gruul's Lair"] .. ")"] = { 29099, 29088, 29094, 29083, 29078, 29069, 29074, 29063, 29053, 29059, 29046, 29042, 29030, 29036, 28966, 29015, 29022 }		-- T4 leggings
		},
		[format(L["Tier %d Tokens"], 5)] = {
			[BB["Lady Vashj"] .. " (" .. BZ["Serpentshrine Cavern"] .. ")"] = { 30228, 30219, 30233, 30141, 30206, 30125, 30131, 30136, 30152, 30161, 30146, 30190, 30166, 30171, 30212, 30115, 30120 },		-- T5 helm
			[BB["Void Reaver"] .. " (" .. BZ["The Eye"] .. ")"] = { 30230, 30221, 30235, 30143, 30210, 30127, 30133,  30138, 30154, 30163, 30149, 30194, 30168, 30173, 30215, 30117, 30122 },		-- T5 shoulders
			[BB["Kael'thas Sunstrider"] .. " (" .. BZ["The Eye"] .. ")"] = { 30222, 30216, 30231, 30139, 30196, 30123, 30129, 30134, 30150, 30159, 30144, 30185, 30164, 30169, 30214, 30113, 30118 }, 	-- T5 chest
			[BB["Leotheras the Blind"] .. " (" .. BZ["Serpentshrine Cavern"] .. ")"] = { 30223, 30217, 30232, 30140, 30205, 30124, 30130, 30135, 30151, 30160, 30145, 30189, 30165, 30170, 30211, 30114, 30119 },		-- T5 gloves
			[BB["Fathom-Lord Karathress"] .. " (" .. BZ["Serpentshrine Cavern"] .. ")"] = { 30229, 30220, 30234, 30142, 30207, 30126, 30132, 30137, 30153, 30162, 30148, 30192, 30167, 30172, 30213, 30116, 30121 }		-- T5 leggings
		},
		[format(L["Tier %d Tokens"], 6)] = {
			[BB["Azgalor"] .. " (" .. BZ["Hyjal Summit"] .. ")"] = { 31034, 31032, 31035, 31001, 31055, 30985, 30982, 30983, 31060, 31061, 31026, 31011, 31007, 31008, 31050, 30970, 30969 },		-- T6 gloves
			[BB["Archimonde"] .. " (" .. BZ["Hyjal Summit"] .. ")"] = { 31039, 31037, 31040, 31003, 31056, 30987, 30989, 30988, 31063, 31064, 31027, 31015, 31012, 31014, 31051, 30974, 30972 },		-- T6 helm
			[BB["Mother Shahraz"] .. " (" .. BZ["Black Temple"] .. ")"] = { 31048, 31047, 31049, 31006, 31059, 30997, 30998, 30996, 31069, 31070, 31030, 31024, 31022, 31023, 31054, 30980, 30979 },		-- T6 shoulders
			[BB["The Illidari Council"] .. " (" .. BZ["Black Temple"] .. ")"] = { 31044, 31045, 31046, 31005, 31058, 30995, 30993, 30994, 31068, 31067, 31029, 31021, 31019, 31020, 31053, 30978, 30977 },		-- T6 leggings
			[BB["Illidan Stormrage"] .. " (" .. BZ["Black Temple"] .. ")"] = { 31042, 31041, 31043, 31004, 31057, 30991, 30990, 30992, 31066, 31065, 31028, 31018, 31016, 31017, 31052, 30976, 30975 },		-- T6 chest
			[BB["Kalecgos"] .. " (" .. BZ["Sunwell Plateau"] .. ")"] = { 34444, 34445, 34446, 34443, 34447, 34433, 34431, 34432, 34435, 34434, 34448, 34439, 34438, 34437, 34436, 34442, 34441 },		-- T6 bracers
			[BB["Brutallus"] .. " (" .. BZ["Sunwell Plateau"] .. ")"] = { 34556, 34554, 34555, 34549, 34557, 34488, 34485, 34487, 34527, 34528, 34558, 34545, 34543, 34542, 34541, 34547, 34546 },		-- T6 belt
			[BB["Felmyst"] .. " (" .. BZ["Sunwell Plateau"] .. ")"] = { 34573, 34571, 34572, 34570, 34574, 34560, 34561, 34559, 34562, 34563, 34575, 34567, 34565, 34566, 34564, 34568, 34569 }		-- T6 boots
		},

		[L["Blizzard Collectables"]] = {	
			[L["WoW Collector Edition"]] = {	13582, 13583, 13584 },
			[L["BC Collector Edition (Europe)"]] = { 25535, 30360 },
			[L["Blizzcon 2005"]] = { 20371 },
			[L["Blizzcon 2007"]] = { 33079 },
			["Worldwide Invitational Paris 2008"] = { 39656 },
			[L["Christmas Gift 2006"]] = { 22114 }
		},
		[L["Upper Deck"]] = {
			[L["Loot Card Items"]] = { 23705, 23713, 23720, 32588, 32566, 32542, 33225, 33224, 33223, 33219, 34493, 34492, 34499, 35226, 35225, 35223, 35227, 38050, 38301, 38233, 38312, 23709, 38313, 38309, 38310, 38314, 38311, 23716, 23714 }
		},
		
		[ L["Badge of Justice"] ] = {
			["x10"] = { 23572 },
			["x15"] = { 29388, 29389, 29390, 30183, 32227, 32228, 32229, 32230, 32231, 32249 },
			["x20"] = { 30763, 30764, 30767, 30768, 30770, 30774, 30779, 30780, 33502, 33503, 33504, 33505, 33506, 33507, 33508, 33509, 33510 },
			["x25"] = { 29269, 29270, 29271, 29272, 29273, 29274, 29367, 29368, 29369, 29373, 29374, 29375, 29379, 29381, 29382, 29384, 29385, 29386, 32809, 32810, 32811, 32812, 32813, 32814, 32816, 32817, 32818, 32819, 32820, 32821, 32980, 32989, 32997, 33192 },
			["x30"] = { 30761, 30762, 30766, 30769, 30772, 30773, 30776, 30778 },
			["x33"] = { 29266, 29267, 29268 },
			["x35"] = { 33296, 33325, 33334, 33513, 33516, 33520, 33529, 33532, 33535, 33540, 33557, 33578, 33580, 33588, 33589, 33593 },
			["x40"] = { 32785, 32786, 32787, 32788, 32789, 32790, 32791, 32792, 32793, 32794, 32795, 32796, 32797, 32798, 32799, 32800, 32801, 32802, 32803, 32804, 32805, 32806, 32807, 32808, 32979, 32981, 32988, 32990, 32998, 32999 },
			["x41"] = { 29370, 29376, 29383, 29387 },
			["x45"] = { 34949, 34950, 34951, 34952 },
			["x50"] = { 29275, 32083, 32084, 32085, 32086, 32087, 32088, 32089, 32090 },
			["x60"] = { 33207, 33222, 33279, 33280, 33287, 33291, 33304, 33324, 33331, 33333, 33386, 33484, 33512, 33514, 33517, 33519, 33523, 33524, 33528, 33531, 33534, 33536, 33537, 33539, 33559, 33577, 33582, 33583, 33586, 33587, 33970, 33973, 33974, 34887, 34888, 34889, 34890, 35321, 35324 },
			["x75"] = { 33501, 33515, 33518, 33522, 33527, 33530, 33538, 33552, 33566, 33579, 33584, 33585, 33810, 33832, 33965, 33972, 34049, 34050, 34162, 34163, 34902, 34904, 34911, 34916, 34919, 34923, 34926, 34929, 34932, 34935, 34938, 34941, 34944, 34947, 35326 },
			["x100"] = { 34900, 34901, 34903, 34905, 34906, 34910, 34912, 34914, 34917, 34918, 34921, 34922, 34924, 34925, 34927, 34928, 34930, 34931, 34933, 34934, 34936, 34937, 34939, 34940, 34942, 34943, 34945, 34946 },
			["x105"] = { 34893, 34894 },
			["x150"] = { 34891, 34892, 34895, 34896, 34898 },
		},
		
		[L["Emblems of Heroism"]] = {
			["x10"] = { 43102,  },
			["x15"] = { 40705, 40706, 40707, 40708, 40709, 40710, 40711, 40712, 40713, 40714, 40715, 40716,  },
			["x25"] = { 40678, 40679, 40680, 40681, 40698, 40699,  },
			["x30"] = { 40797, 40798, 40799, 40856, 40857, 40858, 40918, 40960, 40998, 41004, 41024, 41041, 41134, 41140, 41208, 41214, 41268, 41271, 41278, 41290, 41643, 41646, 41712, 41770, 41847, 41850, 41930, 41937, 41962, 41968, 42008, 42014,  },
			["x35"] = { 40700, 40701,  },
			["x40"] = { 40682, 40683, 40684, 40685, 40688, 40689, 40691, 40692, 40693, 40694, 40695, 40696, 40697, 42944, 42945, 42949, 42950, 42951, 42952, 42984, 42985, 48677, 48683, 48685, 48687, 48689, 48691, 48716,  },
			["x45"] = { 40778, 40779, 40780, 40816, 40817, 40818, 40836, 40837, 40838, 40898, 40930, 40936, 40986, 40987, 41010, 41016, 41023, 41030, 41078, 41084, 41148, 41154, 41160, 41202, 41269, 41270, 41272, 41301, 41313, 41324, 41644, 41645, 41647, 41658, 41664, 41675, 41848, 41849, 41851, 41912, 41918, 41924, 41943, 41949, 41956, 41990, 41996, 42002,  },
			["x50"] = { 40702, 40703, 40704, 42948, 42991, 42992,  },
			["x60"] = { 40613, 40614, 40615,  },
			["x65"] = { 42943, 42946, 42947, 48718,  },
			["x80"] = { 40610, 40611, 40612,  },
			["x200"] = { 44230, 44231,  },
		},
		[L["Emblems of Valor"]] = {
			["x1"] = { 40752,  },
			["x25"] = { 39728, 39757, 40191, 40207, 40267, 40268, 40321, 40322, 40337, 40342, 40717, 40718, 40719, 40720, 40721, 40722, 40723, 40724,  },
			["x30"] = { 40801, 40802, 40803, 40859, 40860, 40861, 40925, 40961, 40999, 41005, 41036, 41042, 41135, 41141, 41209, 41215, 41273, 41279, 41284, 41291, 41681, 41713, 41765, 41771, 41867, 41872, 41931, 41938, 41963, 41969, 42009, 42015,  },
			["x40"] = { 40742, 40743, 40745, 40746, 40747, 40748, 40749, 40750, 40751,  },
			["x45"] = { 40781, 40782, 40783, 40819, 40820, 40821, 40840, 40841, 40842, 40904, 40931, 40937, 40988, 40989, 41011, 41017, 41025, 41031, 41079, 41085, 41149, 41155, 41162, 41203, 41296, 41302, 41308, 41314, 41319, 41325, 41648, 41653, 41659, 41665, 41670, 41676, 41852, 41857, 41862, 41913, 41919, 41925, 41944, 41950, 41957, 41991, 42001, 42003,  },
			["x60"] = { 40637, 40638, 40639, 40733, 40734, 40735, 40736, 40737, 40738, 40739, 40740, 40741,  },
			["x75"] = { 40634, 40635, 40636,  },
		},
		[L["Emblem of Conquest"]] = {
			["x1"] = { 40753,  },
			["x18"] = { 45087,  },
			["x19"] = { 45114, 45144, 45145, 45169, 45254, 45255, 45270, 45436, 45509, 45510, 45819, 45820, 45821, 45822, 45823, 46138,  },
			["x28"] = { 45824, 45825, 45826, 45827, 45828, 45829, 45830, 45831, 45833, 45834, 45835, 45836, 45837, 45838, 45839, 45840,  },
			["x39"] = { 45841, 45842, 45843, 45844, 45845, 45846, 45847, 45848,  },
			["x46"] = { 40804, 40805, 40806, 40862, 40863, 40864, 40926, 40962, 41000, 41006, 41037, 41043, 41136, 41142, 41210, 41216, 41274, 41280, 41286, 41292, 41682, 41714, 41766, 41772, 41868, 41873, 41933, 41939, 41964, 41970, 41992, 42010, 42016,  },
			["x58"] = { 40784, 40785, 40786, 40823, 40824, 40825, 40844, 40845, 40846, 40905, 40932, 40938, 40990, 40991, 41012, 41018, 41026, 41032, 41080, 41086, 41150, 41156, 41198, 41204, 41297, 41303, 41309, 41315, 41320, 41326, 41649, 41654, 41660, 41666, 41671, 41677, 41853, 41858, 41863, 41914, 41920, 41926, 41945, 41951, 41958, 41997, 42004, 45632, 45633, 45634, 45638, 45639, 45640,  },
		},
		
		[L["Emblem of Triumph"]] = {
			["x1"] = { 43950, 44710, 44711, 44713, 45624, 49702,  },
			["x15"] = { 47556,  },
			["x25"] = {
				47658, 47659, 47660, 47661, 47662, 47664, 47665, 47666, 47667, 47668, 47670, 47671, 47672, 47673, 
			},
			["x35"] = { 47729, 47730, 47731, 47732, 47733,  },
			["x45"] = {
				47696, 47697, 47698, 47699, 47701, 47702, 47704, 47705, 47706, 47707, 47708, 47709, 47710, 47712, 47713, 47714, 47715, 47716, 
			},
			["x50"] = {
				40807, 40808, 40809, 40866, 40868, 40869, 40927, 40963, 41001, 41007, 41038, 41044, 41137, 41143, 41211, 41217, 41275, 41281, 41287, 41293, 41683, 41715, 41767, 41773, 41869, 41874, 41934, 41940, 41965, 41971, 42011, 42017, 47734, 47735, 48722, 48724, 
			},
			["x75"] = {
				40787, 40788, 40789, 40826, 40827, 40828, 40847, 40848, 40849, 40907, 40933, 40939, 40992, 40993, 41013, 41019, 41027, 41033, 41081, 41087, 41151, 41157, 41199, 41205, 41298, 41304, 41310, 41316, 41321, 41327, 41650, 41655, 41661, 41667, 41672, 41678, 41854, 41859, 41864, 41915, 41921, 41927, 41946, 41953, 41959, 41993, 41998, 42005, 47674, 47675, 47677, 47678, 47681, 47682, 47684, 47685, 47686, 47687, 47688, 47689, 47690, 47691, 47692, 47693, 47694, 47695, 
			},
		},
		
		[L["Emblem of Frost"]] = {
			["x1"] = { 47241,  },
			["x23"] = { 49908,  },
			["x50"] = { 50466, 50467, 50468, 50469, 50470,  },
			["x60"] = {
				40810, 40811, 40812, 40870, 40871, 40872, 40928, 40964, 41002, 41008, 41039, 41045, 41138, 41144, 41212, 41218, 41276, 41282, 41288, 41294, 41684, 41716, 41768, 41774, 41870, 41875, 41935, 41941, 41966, 41972, 42012, 42018, -- pvp gear
				50355, 50356, 50357, 50358, 50976, 50977, 50978, 50979, 50980, 50981, 50982, 50983, 50984, 50987, 50989, 50991, 50992, 50993, 50994, 50995, 50996, 50997, -- pve gear
			},
			["x95"] = {
				40790, 40791, 40792, 40829, 40830, 40831, 40850, 40851, 40852, 40910, 40934, 40940, 40994, 40995, 41014, 41020, 41028, 41034, 41082, 41088, 41152, 41158, 41200, 41206, 41299, 41305, 41311, 41317, 41322, 41328, 41651, 41656, 41662, 41668, 41673, 41679, 41855, 41860, 41865, 41916, 41922, 41928, 41947, 41954, 41960, 41994, 41999, 42006, -- pvp gear
				50965, 50968, 50969, 50970, 50971, 50972, 50973, 50974, 50975, -- pve gear
			},
		},
		
		[format(L["Tier %d Tokens"], 7)] = {
			[BB["Kel'Thuzad"]] = { 39619, 39625, 39553, 39531, 39545, 39578, 39491, 39628, 39635, 39640, 39521, 39514, 39561, 39594, 39602, 39583, 39496, 39605, 39610 },
			[BB["Loatheb"]] = { 39621, 39627, 39556, 39542, 39548, 39581, 39494, 39631, 39637, 39642, 39529, 39518, 39565, 39596, 39604, 39590, 39499, 39608, 39613 },
			[BB["The Four Horsemen"]] = { 39617, 39623, 39554, 39538, 39547, 39579, 39492, 39629, 39633, 39638, 39523, 39515, 39558, 39592, 39597, 39588, 39497, 39606, 39611 },
			[BB["Thaddius"]] = {	39620, 39626, 39555, 39539, 39546, 39580, 39493, 39630, 39636, 39641, 39528, 39517, 39564, 39595, 39603, 39589, 39498, 39607, 39612 },
			[BB["Sartharion"]] = { 39618, 39624, 39557, 39543, 39544, 39582, 39495, 39632, 39634, 39639, 39530, 39519, 39560, 39593, 39601, 39591, 39500, 39609, 39622 },
		},
		[format(L["Tier %s Tokens"], "7.5")] = {
			[BB["Kel'Thuzad"]] = { 40565, 40554, 40473, 40461, 40467, 40505, 40416, 40571, 40576, 40581, 40456, 40447, 40499, 40510, 40521, 40516, 40421, 40528, 40546 },
			[BB["Loatheb"]] = { 40568, 40557, 40494, 40465, 40470, 40507, 40419, 40573, 40578, 40584, 40459, 40450, 40502, 40513, 40524, 40518, 40424, 40530, 40548 },
			[BB["The Four Horsemen"]] = { 40559, 40550, 40471, 40463, 40469, 40503, 40418, 40569, 40574, 40579, 40458, 40449, 40495, 40508, 40523, 40514, 40423, 40525, 40544 },
			[BB["Thaddius"]] = {	40567, 40556, 40493, 40462, 40468, 40506, 40417, 40572, 40577, 40583, 40457, 40448, 40500, 40512, 40522, 40517, 40422, 40529, 40547 },
			[BB["Sartharion"]] = { 40563, 40552, 40472, 40460, 40466, 40504, 40415, 40570, 40575, 40580, 40454, 40445, 40496, 40509, 40520, 40515, 40420, 40527, 40545 },
		},
		
		[format(L["Tier %d Tokens"], 8)] = {
			[format("%s (%s %s)", BB["Hodir"], BZ["Ulduar"], "10")] = { 	-- 45650, 45651, 45652
				45338, 45343, 45347, 45353, 45357, 45362, 45367, 45371, 45379, 45384, 45388, 45394, 45399, 45403, 45409, 45416, 45420, 45427, 45432, 
			},
			[format("%s (%s %s)", BB["Thorim"], BZ["Ulduar"], "10")] = { 	-- 45659, 45660, 45661
				45339, 45344, 45349, 45352, 45359, 45363, 45369, 45373, 45380, 45385, 45390, 45393, 45400, 45404, 45410, 45415, 45422, 45428, 45433, 
			},
			[format("%s (%s %s)", BB["Freya"], BZ["Ulduar"], "10")] = { 	-- 45644, 45645, 45646
				45337, 45341, 45345, 45351, 45355, 45360, 45370, 45376, 45383, 45387, 45392, 45397, 45401, 45406, 45414, 45419, 45426, 45430, 46131, 
			},
			[format("%s (%s %s)", BB["Mimiron"], BZ["Ulduar"], "10")] = { 	-- 45647, 45648, 45649
				45336, 45342, 45346, 45356, 45361, 45365, 45372, 45377, 45382, 45386, 45391, 45398, 45402, 45408, 45412, 45417, 45425, 45431, 46313, 
			},
			[format("%s (%s %s)", BB["Yogg-Saron"], BZ["Ulduar"], "10")] = { 	-- 45635, 45636, 45637
				45335, 45340, 45348, 45354, 45358, 45364, 45368, 45374, 45375, 45381, 45389, 45395, 45396, 45405, 45411, 45413, 45421, 45424, 45429, 
			},
		},
		[format(L["Tier %s Tokens"], "8.5")] = {
			[format("%s (%s %s)", BB["Hodir"], BZ["Ulduar"], "25")] = { 	-- 45632, 45633, 45634
				46111, 46118, 46123, 46130, 46137, 46141, 46146, 46154, 46159, 46162, 46168, 46173, 46178, 46186, 46193, 46194, 46198, 46205, 46206, 
			},
			[format("%s (%s %s)", BB["Thorim"], BZ["Ulduar"], "25")] = { 	-- 45638, 45639, 45640
				46115, 46120, 46125, 46129, 46140, 46143, 46151, 46156, 46161, 46166, 46172, 46175, 46180, 46184, 46191, 46197, 46201, 46209, 46212, 
			},
			[format("%s (%s %s)", BB["Freya"], BZ["Ulduar"], "25")] = { 	-- 45653, 45654, 45655
				46116, 46121, 46126, 46133, 46139, 46144, 46150, 46153, 46160, 46169, 46170, 46176, 46181, 46185, 46192, 46195, 46202, 46208, 46210, 
			},
			[format("%s (%s %s)", BB["Mimiron"], BZ["Ulduar"], "25")] = { 	-- 45641, 45642, 45643
				46113, 46119, 46124, 46132, 46135, 46142, 46148, 46155, 46158, 46163, 46164, 46174, 46179, 46183, 46188, 46189, 46199, 46200, 46207, 
			},
			[format("%s (%s %s)", BB["Yogg-Saron"], BZ["Ulduar"], "25")] = { 	-- 45656, 45657, 45658
				46117, 46122, 46127, 46134, 46136, 46145, 46149, 46152, 46157, 46165, 46167, 46177, 46182, 46187, 46190, 46196, 46203, 46204, 46211, 
			},
			[format("%s x58", L["Emblem of Conquest"])] = { 	-- 45632, 45633, 45634, 45638, 45639, 45640
				46111, 46118, 46123, 46130, 46137, 46141, 46146, 46154, 46159, 46162, 46168, 46173, 46178, 46186, 46193, 46194, 46198, 46205, 46206, 
				46115, 46120, 46125, 46129, 46140, 46143, 46151, 46156, 46161, 46166, 46172, 46175, 46180, 46184, 46191, 46197, 46201, 46209, 46212, 
			},
		},
		
		["T9-Set"] = {
			[format("%s x%d", L["Emblem of Triumph"], 30)] = { 
				47751, 47752, 47773, 47777, 47783, 47787, 47798, 47802, 47981, 47982, 48067, 48071, 48072, 48076, 48097, 48101, 48131, 48132, 48153, 48157, 48161, 48162, 48183, 48187, 48191, 48192, 48213, 48217, 48221, 48222, 48244, 48247, 48253, 48254, 48276, 48279, 48283, 48284, 48296, 48299, 48312, 48315, 48337, 48340, 48342, 48345, 48367, 48370, 48374, 48375, 48387, 48390, 48448, 48449, 48457, 48460, 48478, 48480, 48502, 48505, 48535, 48537, 48559, 48562, 48572, 48574, 48595, 48598, 48603, 48606, 48627, 48630, 48633, 48636, 48653, 48656, 
			},
			[format("%s x%d", L["Emblem of Triumph"], 50)] = { 
				47748, 47749, 47750, 47774, 47775, 47776, 47784, 47785, 47786, 47799, 47800, 47801, 47914, 47936, 47980, 48068, 48069, 48070, 48073, 48074, 48075, 48098, 48099, 48100, 48102, 48129, 48130, 48154, 48155, 48156, 48158, 48159, 48160, 48184, 48185, 48186, 48188, 48189, 48190, 48214, 48215, 48216, 48218, 48219, 48220, 48243, 48245, 48246, 48250, 48251, 48252, 48275, 48277, 48278, 48280, 48281, 48282, 48295, 48297, 48298, 48310, 48313, 48314, 48336, 48338, 48339, 48341, 48343, 48344, 48366, 48368, 48369, 48371, 48372, 48373, 48386, 48388, 48389, 48429, 48436, 48445, 48456, 48458, 48459, 48472, 48474, 48476, 48501, 48503, 48504, 48529, 48531, 48533, 48558, 48560, 48561, 48564, 48566, 48568, 48596, 48597, 48599, 48602, 48604, 48605, 48628, 48629, 48631, 48632, 48634, 48635, 48652, 48654, 48655, 
			},
		},
		["T9.5-Set"] = {
			[format("%s + %s x%d", L["Trophy of the Crusade"], L["Emblem of Triumph"], 45)] = { 
				47753, 47757, 47768, 47772, 47781, 47782, 47803, 47807, 47983, 47987, 48062, 48066, 48077, 48081, 48092, 48096, 48133, 48137, 48148, 48152, 48163, 48167, 48178, 48182, 48193, 48197, 48208, 48212, 48224, 48227, 48238, 48241, 48256, 48259, 48270, 48273, 48286, 48289, 48301, 48304, 48317, 48320, 48331, 48334, 48347, 48350, 48361, 48364, 48377, 48380, 48392, 48395, 48452, 48454, 48462, 48465, 48482, 48485, 48496, 48499, 48539, 48542, 48553, 48556, 48576, 48579, 48590, 48593, 48608, 48611, 48622, 48625, 48637, 48640, 48658, 48661, 
			},
			[format("%s + %s x%d", L["Trophy of the Crusade"], L["Emblem of Triumph"], 75)] = {
				47754, 47755, 47756, 47769, 47770, 47771, 47778, 47779, 47780, 47804, 47805, 47806, 47984, 47985, 47986, 48063, 48064, 48065, 48078, 48079, 48080, 48093, 48094, 48095, 48134, 48135, 48136, 48149, 48150, 48151, 48164, 48165, 48166, 48179, 48180, 48181, 48194, 48195, 48196, 48209, 48210, 48211, 48223, 48225, 48226, 48239, 48240, 48242, 48255, 48257, 48258, 48271, 48272, 48274, 48285, 48287, 48288, 48300, 48302, 48303, 48316, 48318, 48319, 48332, 48333, 48335, 48346, 48348, 48349, 48362, 48363, 48365, 48376, 48378, 48379, 48391, 48393, 48394, 48430, 48446, 48450, 48461, 48463, 48464, 48481, 48483, 48484, 48497, 48498, 48500, 48538, 48540, 48541, 48554, 48555, 48557, 48575, 48577, 48578, 48591, 48592, 48594, 48607, 48609, 48610, 48623, 48624, 48626, 48638, 48639, 48641, 48657, 48659, 48660, 
			},
		},
		[format(L["Tier %s Tokens"], "9.75")] = {
			[format("%s (%s %s)", L["Tribute Run"], BZ["Trial of the Crusader"], "25 HC")] = {
				-- Regalia of the Grand Conqueror
				48582, 48580, 48581, 48583, 48584, 	-- paladin
				48587, 48585, 48586, 48588, 48589, 	-- paladin
				48614, 48612, 48613, 48615, 48616, 	-- paladin
				48619, 48621, 48620, 48618, 48617, 	-- paladin
				48644, 48646, 48645, 48643, 48642, 	-- paladin
				48649, 48647, 48648, 48650, 48651, 	-- paladin
				48035, 48029, 48033, 48037, 48031, 	-- priest
				48058, 48061, 48059, 48057, 48060, 	-- priest
				48085, 48082, 48084, 48086, 48083, 	-- priest
				48088, 48091, 48089, 48087, 48090, 	-- priest
				47789, 47792, 47790, 47788, 47791, 	-- warlock
				47796, 47793, 47795, 47797, 47794, 	-- warlock
				-- Regalia of the Grand Protector
				48383, 48381, 48382, 48384, 48385, 	-- warrior
				48398, 48400, 48399, 48397, 48396, 	-- warrior
				48433, 48455, 48447, 48453, 48451, 	-- warrior
				48468, 48470, 48469, 48467, 48466, 	-- warrior
				48262, 48260, 48261, 48263, 48264, 	-- hunter
				48267, 48269, 48268, 48266, 48265, 	-- hunter
				48292, 48290, 48291, 48293, 48294, 	-- shaman
				48307, 48309, 48308, 48306, 48305, 	-- shaman
				48323, 48321, 48322, 48324, 48325, 	-- shaman
				48328, 48330, 48329, 48327, 48326, 	-- shaman
				48353, 48351, 48352, 48354, 48355, 	-- shaman
				48358, 48360, 48359, 48357, 48356, 	-- shaman
				-- Regalia of the Grand Vanquisher
				48230, 48228, 48229, 48231, 48232, 	-- rogue
				48235, 48237, 48236, 48234, 48233, 	-- rogue
				48488, 48486, 48487, 48489, 48490, 	-- deathknight
				48493, 48495, 48494, 48492, 48491, 	-- deathknight
				48545, 48543, 48544, 48546, 48547, 	-- deathknight
				48550, 48552, 48551, 48549, 48548, 	-- deathknight
				47761, 47758, 47760, 47762, 47759, 	-- mage
				47764, 47767, 47765, 47763, 47766, 	-- mage
				48141, 48138, 48140, 48142, 48139, 	-- druid
				48144, 48147, 48145, 48143, 48146, 	-- druid
				48171, 48168, 48170, 48172, 48169, 	-- druid
				48174, 48177, 48175, 48173, 48176, 	-- druid
				48201, 48198, 48200, 48202, 48199, 	-- druid
				48204, 48207, 48205, 48203, 48206, 	-- druid
			},
		},
		
		["T10-Set"] = {
			[format("%s x%d", L["Emblem of Frost"], 60)] = { 
				50107, 50113, 50819, 50822, 50824, 50827,  -- Druide
				50240, 50244,  -- Hexenmeister
				50114, 50117,  -- Jäger
				50079, 50082, 50846, 50849,  -- Krieger
				50275, 50279,  -- Magier
				50324, 50327, 50860, 50863, 50865, 50868,  -- Paladin
				50391, 50396, 50766, 50767,  -- Priester
				50831, 50834, 50836, 50839, 50842, 50845,  -- Schamane
				50088, 50105,  -- Schurke
				50095, 50098, 50853, 50856,  -- Todesritter
			},
			[format("%s x%d", L["Emblem of Frost"], 95)] = { 
				50106, 50108, 50109, 50820, 50821, 50823, 50825, 50826, 50828,  -- Druide
				50241, 50242, 50243,  -- Hexenmeister
				50115, 50116, 50118,  -- Jäger
				50078, 50080, 50081, 50847, 50848, 50850,  -- Krieger
				50276, 50277, 50278,  -- Magier
				50325, 50326, 50328, 50861, 50862, 50864, 50866, 50867, 50869,  -- Paladin
				50392, 50393, 50394, 50765, 50768, 50769,  -- Priester
				50830, 50832, 50833, 50835, 50837, 50838, 50841, 50843, 50844,  -- Schamane
				50087, 50089, 50090,  -- Schurke
				50094, 50096, 50097, 50854, 50855, 50857,  -- Todesritter
			},
		},
		[format(L["Tier %s Tokens"], "10.5")] = {
			[format("%s-%s (%s %s)", L["Quarter_Wing"], BOSS, BZ["Icecrown Citadel"], "25")] = {
				-- Vanquisher
				51185, 51186, 51187, 51188, 51189,  -- Rogue
				51125, 51126, 51127, 51128, 51129, 51130, 51131, 51132, 51133, 51134,  -- Death Knight
				51155, 51156, 51157, 51158, 51159,  -- Mage
				51135, 51136, 51137, 51138, 51139, 51140, 51141, 51142, 51143, 51144, 51145, 51146, 51147, 51148, 51149,  -- Druid
				-- Protector
				51210, 51211, 51212, 51213, 51214, 51215, 51216, 51217, 51218, 51219,  -- Warrior
				51150, 51151, 51152, 51153, 51154,  -- Hunter
				51190, 51191, 51192, 51193, 51194, 51195, 51196, 51197, 51198, 51199, 51200, 51201, 51202, 51203, 51204,  -- Shaman
				-- Conqueror
				51160, 51161, 51162, 51163, 51164, 51165, 51166, 51167, 51168, 51169, 51170, 51171, 51172, 51173, 51174,  -- Paladin
				51175, 51176, 51177, 51178, 51179, 51180, 51181, 51182, 51183, 51184,  -- Priest
				51205, 51206, 51207, 51208, 51209,  -- Warlock
			},
		},
		[format(L["Tier %s Tokens"], "10.75") .. L[" (Heroic)"]] = {
			[format("%s-%s (%s %s)", L["Quarter_Wing"], BOSS, BZ["Icecrown Citadel"], "25 HC")] = {
				51221, 51224, 51223, 51222, 51220, 	-- warrior
				51227, 51229, 51228, 51226, 51225, 	-- warrior
				51266, 51269, 51268, 51267, 51265, 	-- paladin
				51272, 51273, 51271, 51270, 51274, 	-- paladin
				51277, 51279, 51278, 51276, 51275, 	-- paladin
				51286, 51288, 51287, 51285, 51289, 	-- hunter
				51252, 51254, 51253, 51251, 51250, 	-- rogue
				51255, 51257, 51258, 51256, 51259, 	-- priest
				51261, 51264, 51262, 51260, 51263, 	-- priest
				51306, 51309, 51308, 51307, 51305, 	-- deathknight
				51312, 51314, 51313, 51311, 51310, 	-- deathknight
				51237, 51235, 51236, 51238, 51239, 	-- shaman
				51242, 51240, 51241, 51243, 51244, 	-- shaman
				51247, 51245, 51246, 51248, 51249, 	-- shaman
				51281, 51284, 51282, 51280, 51283, 	-- mage
				51231, 51234, 51232, 51230, 51233, 	-- warlock
				51290, 51292, 51293, 51291, 51294, 	-- druid
				51296, 51299, 51297, 51295, 51298, 	-- druid
				51302, 51304, 51303, 51301, 51300, 	-- druid
			},
		},
		
		
		[L["World Drops"]] = {
			[L["Level 30-39"]] = { 867, 1981, 1980, 869, 1982, 870, 868, 873, 1204, 2825 },
			[L["Level 40-49"]] = {
				3075, 940, 14551, 17007, 14549, 1315, 942, 1447, 2164,  2163, 
				809, 871, 2291, 810, 2915, 812, 943, 1169, 1979, 2824, 2100, 
			},
			[L["Level 50-60"]] = {
				3475, 14553, 2245, 14552, 14554, 1443, 14558, 2246, 833, 14557, 
				1728, 14555, 2244, 2801, 647, 811, 1263, 2243, 944, 1168, 2099, 
			},
			[L["Level 70"]] = {
				34703, 28189, 31329, 31340, 31343, 31333, 31330, 31328, 31335, 31320, 
				31338, 31321, 31319, 31339, 31326, 31331, 31336, 31332, 31318, 31342, 
				31322, 31334, 34622, 31323, 
			},
			[L["Level 80"]] = {
				37254,  -- Super Simian Sphere
				37835,  -- Je'Tze's Bell
				44308,  -- Signet of Edward the Odd
				44309,  -- Sash of Jordan
				44310,  -- Namlak's Supernumerary Sticker
				44311,  -- Avool's Sword of Jin
				44312,  -- Wapach's Spaulders of Solidarity
				44313,  -- Zom's Crackling Bulwark
			},
			[format("%s (%s)", L["Nascent Val'kyr"], BZ["The Storm Peaks"])] = {
				43573,  -- Tears of Bitter Anguish
			},
		},
		
		[L["Pick Pocket"]] = {
			[BZ["Northrend"]] = {
				43575,  -- Reinforced Junkbox
				43611,  -- Krol Cleaver (Reinforced Junkbox)
				43612,  -- Spineslicer (Reinforced Junkbox)
				43613,  -- The Dusk Blade (Reinforced Junkbox)
			},
		},
		
		
		
		[BZ["Vault of Archavon"] ] = {
			[BOSS] 	= { 43959, 44083, },
			
			[L["SHORT_Archavon"].." (10)"] 	= {
				39492, 	-- Heroes' Frostfire Robe
				39493, 	-- Heroes' Frostfire Leggings
				39495, 	-- Heroes' Frostfire Gloves
				39497, 	-- Heroes' Plagueheart Robe
				39498, 	-- Heroes' Plagueheart Leggings
				39500, 	-- Heroes' Plagueheart Gloves
				39515, 	-- Heroes' Robe of Faith
				39517, 	-- Heroes' Leggings of Faith
				39519, 	-- Heroes' Gloves of Faith
				39523, 	-- Heroes' Raiments of Faith
				39528, 	-- Heroes' Pants of Faith
				39530, 	-- Heroes' Handwraps of Faith
				39538, 	-- Heroes' Dreamwalker Robe
				39539, 	-- Heroes' Dreamwalker Leggings
				39543, 	-- Heroes' Dreamwalker Handguards
				39544, 	-- Heroes' Dreamwalker Gloves
				39546, 	-- Heroes' Dreamwalker Trousers
				39547, 	-- Heroes' Dreamwalker Vestments
				39554, 	-- Heroes' Dreamwalker Raiments
				39555, 	-- Heroes' Dreamwalker Legguards
				39557, 	-- Heroes' Dreamwalker Handgrips
				39558, 	-- Heroes' Bonescythe Breastplate
				39560, 	-- Heroes' Bonescythe Gauntlets
				39564, 	-- Heroes' Bonescythe Legplates
				39579, 	-- Heroes' Crypstalker Tunic
				39580, 	-- Heroes' Crypstalker Legguards
				39582, 	-- Heroes' Crypstalker Handguards
				39588, 	-- Heroes' Earthshatter Tunic
				39589, 	-- Heroes' Earthshatter Legguards
				39591, 	-- Heroes' Earthshatter Handguards
				39592, 	-- Heroes' Earthshatter Hauberk
				39593, 	-- Heroes' Earthshatter Gloves
				39595, 	-- Heroes' Earthshatter Kilt
				39597, 	-- Heroes' Earthshatter Chestguard
				39601, 	-- Heroes' Earthshatter Grips
				39603, 	-- Heroes' Earthshatter War-Kilt
				39606, 	-- Heroes' Dreadnaught Battleplate
				39607, 	-- Heroes' Dreadnaught Legplates
				39609, 	-- Heroes' Dreadnaught Gauntlets
				39611, 	-- Heroes' Dreadnaught Breastplate
				39612, 	-- Heroes' Dreadnaught Legguards
				39617, 	-- Heroes' Scourgeborne Battleplate
				39618, 	-- Heroes' Scourgeborne Gauntlets
				39620, 	-- Heroes' Scourgeborne Legplates
				39622, 	-- Heroes' Dreadnaught Handguards
				39623, 	-- Heroes' Scourgeborne Chestguard
				39624, 	-- Heroes' Scourgeborne Handguards
				39626, 	-- Heroes' Scourgeborne Legguards
				39629, 	-- Heroes' Redemption Tunic
				39630, 	-- Heroes' Redemption Greaves
				39632, 	-- Heroes' Redemption Gloves
				39633, 	-- Heroes' Redemption Chestpiece
				39634, 	-- Heroes' Redemption Gauntlets
				39636, 	-- Heroes' Redemption Legplates
				39638, 	-- Heroes' Redemption Breastplate
				39639, 	-- Heroes' Redemption Handguards
				39641, 	-- Heroes' Redemption Legguards
				40781, 	-- Hateful Gladiator's Dreadplate Chestpiece
				40782, 	-- Hateful Gladiator's Scaled Chestpiece
				40783, 	-- Hateful Gladiator's Plate Chestpiece
				40801, 	-- Hateful Gladiator's Plate Gauntlets
				40802, 	-- Hateful Gladiator's Scaled Gauntlets
				40803, 	-- Hateful Gladiator's Dreadplate Gauntlets
				40840, 	-- Hateful Gladiator's Plate Legguards
				40841, 	-- Hateful Gladiator's Dreadplate Legguards
				40842, 	-- Hateful Gladiator's Scaled Legguards
				40904, 	-- Hateful Gladiator's Ornamented Chestguard
				40925, 	-- Hateful Gladiator's Ornamented Gloves
				40937, 	-- Hateful Gladiator's Ornamented Legplates
				40988, 	-- Hateful Gladiator's Ringmail Armor
				40989, 	-- Hateful Gladiator's Mail Armor
				40999, 	-- Hateful Gladiator's Ringmail Gauntlets
				41005, 	-- Hateful Gladiator's Mail Gauntlets
				41025, 	-- Hateful Gladiator's Ringmail Leggings
				41031, 	-- Hateful Gladiator's Mail Leggings
				41079, 	-- Hateful Gladiator's Linked Armor
				41085, 	-- Hateful Gladiator's Chain Armor
				41135, 	-- Hateful Gladiator's Linked Gauntlets
				41141, 	-- Hateful Gladiator's Chain Gauntlets
				41162, 	-- Hateful Gladiator's Linked Leggings
				41203, 	-- Hateful Gladiator's Chain Leggings
				41284, 	-- Hateful Gladiator's Kodohide Gloves
				41291, 	-- Hateful Gladiator's Wyrmhide Gloves
				41296, 	-- Hateful Gladiator's Kodohide Legguards
				41302, 	-- Hateful Gladiator's Wyrmhide Legguards
				41308, 	-- Hateful Gladiator's Kodohide Robes
				41314, 	-- Hateful Gladiator's Wyrmhide Robes
				41648, 	-- Hateful Gladiator's Leather Tunic
				41653, 	-- Hateful Gladiator's Leather Legguards
				41659, 	-- Hateful Gladiator's Dragonhide Robes
				41665, 	-- Hateful Gladiator's Dragonhide Legguards
				41765, 	-- Hateful Gladiator's Leather Gloves
				41771, 	-- Hateful Gladiator's Dragonhide Gloves
				41857, 	-- Hateful Gladiator's Mooncloth Robe
				41862, 	-- Hateful Gladiator's Mooncloth Leggings
				41872, 	-- Hateful Gladiator's Mooncloth Gloves
				41919, 	-- Hateful Gladiator's Satin Robe
				41925, 	-- Hateful Gladiator's Satin Leggings
				41938, 	-- Hateful Gladiator's Satin Gloves
				41950, 	-- Hateful Gladiator's Silk Raiment
				41957, 	-- Hateful Gladiator's Silk Trousers
				41969, 	-- Hateful Gladiator's Silk Handguards
				42001, 	-- Hateful Gladiator's Felweave Raiment
				42003, 	-- Hateful Gladiator's Felweave Trousers
				42015, 	-- Hateful Gladiator's Felweave Handguards
			},
			[L["SHORT_Emalon"].." (10)"] 	= {
				40804, 	-- Deadly Gladiator's Plate Gauntlets
				40805, 	-- Deadly Gladiator's Scaled Gauntlets
				40806, 	-- Deadly Gladiator's Dreadplate Gauntlets
				40844, 	-- Deadly Gladiator's Plate Legguards
				40845, 	-- Deadly Gladiator's Dreadplate Legguards
				40846, 	-- Deadly Gladiator's Scaled Legguards
				40879, 	-- Deadly Gladiator's Girdle of Triumph
				40880, 	-- Deadly Gladiator's Greaves of Triumph
				40888, 	-- Deadly Gladiator's Bracers of Triumph
				40926, 	-- Deadly Gladiator's Ornamented Gloves
				40938, 	-- Deadly Gladiator's Ornamented Legplates
				40974, 	-- Deadly Gladiator's Girdle of Salvation
				40975, 	-- Deadly Gladiator's Greaves of Salvation
				40982, 	-- Deadly Gladiator's Bracers of Salvation
				41000, 	-- Deadly Gladiator's Ringmail Gauntlets
				41006, 	-- Deadly Gladiator's Mail Gauntlets
				41026, 	-- Deadly Gladiator's Ringmail Leggings
				41032, 	-- Deadly Gladiator's Mail Leggings
				41048, 	-- Deadly Gladiator's Waistguard of Salvation
				41054, 	-- Deadly Gladiator's Sabatons of Salvation
				41059, 	-- Deadly Gladiator's Wristguards of Salvation
				41064, 	-- Deadly Gladiator's Wristguards of Dominance
				41069, 	-- Deadly Gladiator's Waistguard of Dominance
				41074, 	-- Deadly Gladiator's Sabatons of Dominance
				41136, 	-- Deadly Gladiator's Linked Gauntlets
				41142, 	-- Deadly Gladiator's Chain Gauntlets
				41198, 	-- Deadly Gladiator's Linked Leggings
				41204, 	-- Deadly Gladiator's Chain Leggings
				41224, 	-- Deadly Gladiator's Wristguards of Triumph
				41229, 	-- Deadly Gladiator's Sabatons of Triumph
				41234, 	-- Deadly Gladiator's Waistguard of Triumph
				41286, 	-- Deadly Gladiator's Kodohide Gloves
				41292, 	-- Deadly Gladiator's Wyrmhide Gloves
				41297, 	-- Deadly Gladiator's Kodohide Legguards
				41303, 	-- Deadly Gladiator's Wyrmhide Legguards
				41616, 	-- Deadly Gladiator's Belt of Salvation
				41620, 	-- Deadly Gladiator's Boots of Salvation
				41624, 	-- Deadly Gladiator's Armwraps of Salvation
				41629, 	-- Deadly Gladiator's Belt of Dominance
				41634, 	-- Deadly Gladiator's Boots of Dominance
				41639, 	-- Deadly Gladiator's Armwraps of Dominance
				41654, 	-- Deadly Gladiator's Leather Legguards
				41666, 	-- Deadly Gladiator's Dragonhide Legguards
				41766, 	-- Deadly Gladiator's Leather Gloves
				41772, 	-- Deadly Gladiator's Dragonhide Gloves
				41831, 	-- Deadly Gladiator's Belt of Triumph
				41835, 	-- Deadly Gladiator's Boots of Triumph
				41839, 	-- Deadly Gladiator's Armwraps of Triumph
				41863, 	-- Deadly Gladiator's Mooncloth Leggings
				41873, 	-- Deadly Gladiator's Mooncloth Gloves
				41880, 	-- Deadly Gladiator's Cord of Salvation
				41884, 	-- Deadly Gladiator's Treads of Salvation
				41892, 	-- Deadly Gladiator's Cuffs of Salvation
				41897, 	-- Deadly Gladiator's Cord of Dominance
				41902, 	-- Deadly Gladiator's Treads of Dominance
				41908, 	-- Deadly Gladiator's Cuffs of Dominance
				41926, 	-- Deadly Gladiator's Satin Leggings
				41939, 	-- Deadly Gladiator's Satin Gloves
				41958, 	-- Deadly Gladiator's Silk Trousers
				41970, 	-- Deadly Gladiator's Silk Handguards
				42004, 	-- Deadly Gladiator's Felweave Trousers
				42016, 	-- Deadly Gladiator's Felweave Handguards
				42027, 	-- Deadly Gladiator's Pendant of Triumph
				42028, 	-- Deadly Gladiator's Pendant of Victory
				42029, 	-- Deadly Gladiator's Pendant of Dominance
				42030, 	-- Deadly Gladiator's Pendant of Ascendancy
				42031, 	-- Deadly Gladiator's Pendant of Subjugation
				42032, 	-- Deadly Gladiator's Pendant of Deliverance
				42033, 	-- Deadly Gladiator's Pendant of Salvation
				42062, 	-- Deadly Gladiator's Cloak of Dominance
				42063, 	-- Deadly Gladiator's Cloak of Subjugation
				42064, 	-- Deadly Gladiator's Cloak of Ascendancy
				42065, 	-- Deadly Gladiator's Cloak of Salvation
				42066, 	-- Deadly Gladiator's Cloak of Deliverance
				42067, 	-- Deadly Gladiator's Cloak of Triumph
				42068, 	-- Deadly Gladiator's Cloak of Victory
				42114, 	-- Deadly Gladiator's Band of Ascendancy
				42115, 	-- Deadly Gladiator's Band of Victory
				45337, 	-- Valorous Darkruned Handguards
				45338, 	-- Valorous Darkruned Legguards
				45341, 	-- Valorous Darkruned Gauntlets
				45343, 	-- Valorous Darkruned Legplates
				45345, 	-- Valorous Nightsong Handguards
				45347, 	-- Valorous Nightsong Leggings
				45351, 	-- Valorous Nightsong Gloves
				45353, 	-- Valorous Nightsong Trousers
				45355, 	-- Valorous Nightsong Handgrips
				45357, 	-- Valorous Nightsong Legguards
				45360, 	-- Valorous Scourgestalker Handguards
				45362, 	-- Valorous Scourgestalker Legguards
				45367, 	-- Valorous Kirin'dor Leggings
				45370, 	-- Valorous Aegis Gloves
				45371, 	-- Valorous Aegis Greaves
				45376, 	-- Valorous Aegis Gauntlets
				45379, 	-- Valorous Aegis Legplates
				45383, 	-- Valorous Aegis Handguards
				45384, 	-- Valorous Aegis Legguards
				45387, 	-- Valorous Gloves of Sanctification
				45388, 	-- Valorous Leggings of Sanctification
				45392, 	-- Valorous Handwraps of Sanctification
				45394, 	-- Valorous Pants of Sanctification
				45397, 	-- Valorous Terrorblade Gauntlets
				45399, 	-- Valorous Terrorblade Legplates
				45401, 	-- Valorous Worldbreaker Handguards
				45403, 	-- Valorous Worldbreaker Legguards
				45406, 	-- Valorous Worldbreaker Gloves
				45409, 	-- Valorous Worldbreaker Kilt
				45414, 	-- Valorous Worldbreaker Grips
				45416, 	-- Valorous Worldbreaker War-Kilt
				45419, 	-- Valorous Deathbringer Gloves
				45420, 	-- Valorous Deathbringer Leggings
				45426, 	-- Valorous Siegebreaker Handguards
				45427, 	-- Valorous Siegebreaker Legguards
				45430, 	-- Valorous Siegebreaker Gauntlets
				45432, 	-- Valorous Siegebreaker Legplates
				46131, 	-- Valorous Kirin'dor Gauntlets
			},
			[L["SHORT_Koralon"].." (10)"] 	= {
				40807, 	-- Furious Gladiator's Plate Gauntlets
				40808, 	-- Furious Gladiator's Scaled Gauntlets
				40809, 	-- Furious Gladiator's Dreadplate Gauntlets
				40847, 	-- Furious Gladiator's Plate Legguards
				40848, 	-- Furious Gladiator's Dreadplate Legguards
				40849, 	-- Furious Gladiator's Scaled Legguards
				40881, 	-- Furious Gladiator's Girdle of Triumph
				40882, 	-- Furious Gladiator's Greaves of Triumph
				40889, 	-- Furious Gladiator's Bracers of Triumph
				40927, 	-- Furious Gladiator's Ornamented Gloves
				40939, 	-- Furious Gladiator's Ornamented Legplates
				40976, 	-- Furious Gladiator's Girdle of Salvation
				40977, 	-- Furious Gladiator's Greaves of Salvation
				40983, 	-- Furious Gladiator's Bracers of Salvation
				41001, 	-- Furious Gladiator's Ringmail Gauntlets
				41007, 	-- Furious Gladiator's Mail Gauntlets
				41027, 	-- Furious Gladiator's Ringmail Leggings
				41033, 	-- Furious Gladiator's Mail Leggings
				41051, 	-- Furious Gladiator's Waistguard of Salvation
				41055, 	-- Furious Gladiator's Sabatons of Salvation
				41060, 	-- Furious Gladiator's Wristguards of Salvation
				41065, 	-- Furious Gladiator's Wristguards of Dominance
				41070, 	-- Furious Gladiator's Waistguard of Dominance
				41075, 	-- Furious Gladiator's Sabatons of Dominance
				41137, 	-- Furious Gladiator's Linked Gauntlets
				41143, 	-- Furious Gladiator's Chain Gauntlets
				41199, 	-- Furious Gladiator's Linked Leggings
				41205, 	-- Furious Gladiator's Chain Leggings
				41225, 	-- Furious Gladiator's Wristguards of Triumph
				41230, 	-- Furious Gladiator's Sabatons of Triumph
				41235, 	-- Furious Gladiator's Waistguard of Triumph
				41287, 	-- Furious Gladiator's Kodohide Gloves
				41293, 	-- Furious Gladiator's Wyrmhide Gloves
				41298, 	-- Furious Gladiator's Kodohide Legguards
				41304, 	-- Furious Gladiator's Wyrmhide Legguards
				41617, 	-- Furious Gladiator's Belt of Salvation
				41621, 	-- Furious Gladiator's Boots of Salvation
				41625, 	-- Furious Gladiator's Armwraps of Salvation
				41630, 	-- Furious Gladiator's Belt of Dominance
				41635, 	-- Furious Gladiator's Boots of Dominance
				41640, 	-- Furious Gladiator's Armwraps of Dominance
				41655, 	-- Furious Gladiator's Leather Legguards
				41667, 	-- Furious Gladiator's Dragonhide Legguards
				41767, 	-- Furious Gladiator's Leather Gloves
				41773, 	-- Furious Gladiator's Dragonhide Gloves
				41832, 	-- Furious Gladiator's Belt of Triumph
				41836, 	-- Furious Gladiator's Boots of Triumph
				41840, 	-- Furious Gladiator's Armwraps of Triumph
				41864, 	-- Furious Gladiator's Mooncloth Leggings
				41874, 	-- Furious Gladiator's Mooncloth Gloves
				41881, 	-- Furious Gladiator's Cord of Salvation
				41885, 	-- Furious Gladiator's Slippers of Salvation
				41893, 	-- Furious Gladiator's Cuffs of Salvation
				41898, 	-- Furious Gladiator's Cord of Dominance
				41903, 	-- Furious Gladiator's Slippers of Dominance
				41909, 	-- Furious Gladiator's Cuffs of Dominance
				41927, 	-- Furious Gladiator's Satin Leggings
				41940, 	-- Furious Gladiator's Satin Gloves
				41959, 	-- Furious Gladiator's Silk Trousers
				41971, 	-- Furious Gladiator's Silk Handguards
				42005, 	-- Furious Gladiator's Felweave Trousers
				42017, 	-- Furious Gladiator's Felweave Handguards
				42034, 	-- Furious Gladiator's Pendant of Triumph
				42035, 	-- Furious Gladiator's Pendant of Victory
				42036, 	-- Furious Gladiator's Pendant of Dominance
				42037, 	-- Furious Gladiator's Pendant of Ascendancy
				42038, 	-- Furious Gladiator's Pendant of Subjugation
				42039, 	-- Furious Gladiator's Pendant of Deliverance
				42040, 	-- Furious Gladiator's Pendant of Salvation
				42069, 	-- Furious Gladiator's Cloak of Dominance
				42070, 	-- Furious Gladiator's Cloak of Subjugation
				42071, 	-- Furious Gladiator's Cloak of Ascendancy
				42072, 	-- Furious Gladiator's Cloak of Salvation
				42073, 	-- Furious Gladiator's Cloak of Deliverance
				42074, 	-- Furious Gladiator's Cloak of Triumph
				42075, 	-- Furious Gladiator's Cloak of Victory
				42116, 	-- Furious Gladiator's Band of Dominance
				42117, 	-- Furious Gladiator's Band of Triumph
				46373, 	-- Furious Gladiator's Pendant of Sundering
				47750, 	-- Khadgar's Leggings of Conquest
				47752, 	-- Khadgar's Gauntlets of Conquest
				47773, 	-- Sunstrider's Gauntlets of Conquest
				47775, 	-- Sunstrider's Leggings of Conquest
				47783, 	-- Kel'Thuzad's Gloves of Conquest
				47785, 	-- Kel'Thuzad's Leggings of Conquest
				47800, 	-- Gul'dan's Leggings of Conquest
				47802, 	-- Gul'dan's Gloves of Conquest
				47980, 	-- Velen's Leggings of Conquest
				47982, 	-- Velen's Gloves of Conquest
				48067, 	-- Zabra's Gloves of Conquest
				48069, 	-- Zabra's Leggings of Conquest
				48072, 	-- Velen's Handwraps of Conquest
				48074, 	-- Velen's Pants of Conquest
				48097, 	-- Zabra's Handwraps of Conquest
				48099, 	-- Zabra's Pants of Conquest
				48130, 	-- Stormrage's Leggings of Conquest
				48132, 	-- Stormrage's Handguards of Conquest
				48153, 	-- Runetotem's Handguards of Conquest
				48155, 	-- Runetotem's Leggings of Conquest
				48160, 	-- Stormrage's Trousers of Conquest
				48162, 	-- Stormrage's Gloves of Conquest
				48183, 	-- Runetotem's Gloves of Conquest
				48185, 	-- Runetotem's Trousers of Conquest
				48190, 	-- Runetotem's Legguards of Conquest
				48192, 	-- Runetotem's Handgrips of Conquest
				48213, 	-- Stormrage's Handgrips of Conquest
				48215, 	-- Stormrage's Legguards of Conquest
				48220, 	-- VanCleef's Legplates of Conquest
				48222, 	-- VanCleef's Gauntlets of Conquest
				48244, 	-- Garona's Gauntlets of Conquest
				48246, 	-- Garona's Legplates of Conquest
				48252, 	-- Windrunner's Legguards of Conquest
				48254, 	-- Windrunner's Handguards of Conquest
				48276, 	-- Windrunner's Handguards of Conquest
				48278, 	-- Windrunner's Legguards of Conquest
				48282, 	-- Nobundo's Legguards of Conquest
				48284, 	-- Nobundo's Handguards of Conquest
				48296, 	-- Thrall's Handguards of Conquest
				48298, 	-- Thrall's Legguards of Conquest
				48312, 	-- Nobundo's Gloves of Conquest
				48314, 	-- Nobundo's Kilt of Conquest
				48337, 	-- Thrall's Gloves of Conquest
				48339, 	-- Thrall's Kilt of Conquest
				48342, 	-- Nobundo's Grips of Conquest
				48344, 	-- Nobundo's War-Kilt of Conquest
				48367, 	-- Thrall's Grips of Conquest
				48369, 	-- Thrall's War-Kilt of Conquest
				48373, 	-- Wrynn's Legplates of Conquest
				48375, 	-- Wrynn's Gauntlets of Conquest
				48387, 	-- Hellscream's Gauntlets of Conquest
				48389, 	-- Hellscream's Legplates of Conquest
				48445, 	-- Wrynn's Legguards of Conquest
				48449, 	-- Wrynn's Handguards of Conquest
				48457, 	-- Hellscream's Handguards of Conquest
				48459, 	-- Hellscream's Legguards of Conquest
				48476, 	-- Thassarian's Legplates of Conquest
				48480, 	-- Thassarian's Gauntlets of Conquest
				48502, 	-- Koltira's Gauntlets of Conquest
				48504, 	-- Koltira's Legplates of Conquest
				48533, 	-- Thassarian's Legguards of Conquest
				48537, 	-- Thassarian's Handguards of Conquest
				48559, 	-- Koltira's Handguards of Conquest
				48561, 	-- Koltira's Legguards of Conquest
				48568, 	-- Turalyon's Greaves of Conquest
				48574, 	-- Turalyon's Gloves of Conquest
				48596, 	-- Liadrin's Greaves of Conquest
				48598, 	-- Liadrin's Gloves of Conquest
				48603, 	-- Turalyon's Gauntlets of Conquest
				48605, 	-- Turalyon's Legplates of Conquest
				48628, 	-- Liadrin's Legplates of Conquest
				48630, 	-- Liadrin's Gauntlets of Conquest
				48633, 	-- Turalyon's Handguards of Conquest
				48635, 	-- Turalyon's Legguards of Conquest
				48653, 	-- Liadrin's Handguards of Conquest
				48655, 	-- Liadrin's Legguards of Conquest
			},
			[L["SHORT_Toravon"].." (10)"] 	= {
				40810, 	-- Relentless Gladiator's Plate Gauntlets
				40811, 	-- Relentless Gladiator's Dreadplate Gauntlets
				40812, 	-- Relentless Gladiator's Scaled Gauntlets
				40850, 	-- Relentless Gladiator's Plate Legguards
				40851, 	-- Relentless Gladiator's Dreadplate Legguards
				40852, 	-- Relentless Gladiator's Scaled Legguards
				40883, 	-- Relentless Gladiator's Girdle of Triumph
				40884, 	-- Relentless Gladiator's Greaves of Triumph
				40890, 	-- Relentless Gladiator's Bracers of Triumph
				40928, 	-- Relentless Gladiator's Ornamented Gloves
				40940, 	-- Relentless Gladiator's Ornamented Legplates
				40978, 	-- Relentless Gladiator's Girdle of Salvation
				40979, 	-- Relentless Gladiator's Greaves of Salvation
				40984, 	-- Relentless Gladiator's Bracers of Salvation
				41002, 	-- Relentless Gladiator's Ringmail Gauntlets
				41008, 	-- Relentless Gladiator's Mail Gauntlets
				41028, 	-- Relentless Gladiator's Ringmail Leggings
				41034, 	-- Relentless Gladiator's Mail Leggings
				41052, 	-- Relentless Gladiator's Waistguard of Salvation
				41056, 	-- Relentless Gladiator's Sabatons of Salvation
				41061, 	-- Relentless Gladiator's Wristguards of Salvation
				41066, 	-- Relentless Gladiator's Wristguards of Dominance
				41071, 	-- Relentless Gladiator's Waistguard of Dominance
				41076, 	-- Relentless Gladiator's Sabatons of Dominance
				41138, 	-- Relentless Gladiator's Linked Gauntlets
				41144, 	-- Relentless Gladiator's Chain Gauntlets
				41200, 	-- Relentless Gladiator's Linked Leggings
				41206, 	-- Relentless Gladiator's Chain Leggings
				41226, 	-- Relentless Gladiator's Wristguards of Triumph
				41231, 	-- Relentless Gladiator's Sabatons of Triumph
				41236, 	-- Relentless Gladiator's Waistguard of Triumph
				41288, 	-- Relentless Gladiator's Kodohide Gloves
				41294, 	-- Relentless Gladiator's Wyrmhide Gloves
				41299, 	-- Relentless Gladiator's Kodohide Legguards
				41305, 	-- Relentless Gladiator's Wyrmhide Legguards
				41618, 	-- Relentless Gladiator's Belt of Salvation
				41622, 	-- Relentless Gladiator's Boots of Salvation
				41626, 	-- Relentless Gladiator's Armwraps of Salvation
				41631, 	-- Relentless Gladiator's Belt of Dominance
				41636, 	-- Relentless Gladiator's Boots of Dominance
				41641, 	-- Relentless Gladiator's Armwraps of Dominance
				41656, 	-- Relentless Gladiator's Leather Legguards
				41668, 	-- Relentless Gladiator's Dragonhide Legguards
				41768, 	-- Relentless Gladiator's Leather Gloves
				41774, 	-- Relentless Gladiator's Dragonhide Gloves
				41833, 	-- Relentless Gladiator's Belt of Triumph
				41837, 	-- Relentless Gladiator's Boots of Triumph
				41841, 	-- Relentless Gladiator's Armwraps of Triumph
				41865, 	-- Relentless Gladiator's Mooncloth Leggings
				41875, 	-- Relentless Gladiator's Mooncloth Gloves
				41882, 	-- Relentless Gladiator's Cord of Salvation
				41886, 	-- Relentless Gladiator's Treads of Salvation
				41894, 	-- Relentless Gladiator's Cuffs of Salvation
				41899, 	-- Relentless Gladiator's Cord of Dominance
				41904, 	-- Relentless Gladiator's Treads of Dominance
				41910, 	-- Relentless Gladiator's Cuffs of Dominance
				41928, 	-- Relentless Gladiator's Satin Leggings
				41941, 	-- Relentless Gladiator's Satin Gloves
				41960, 	-- Relentless Gladiator's Silk Trousers
				41972, 	-- Relentless Gladiator's Silk Handguards
				42006, 	-- Relentless Gladiator's Felweave Trousers
				42018, 	-- Relentless Gladiator's Felweave Handguards
				42041, 	-- Relentless Gladiator's Pendant of Triumph
				42042, 	-- Relentless Gladiator's Pendant of Victory
				42043, 	-- Relentless Gladiator's Pendant of Dominance
				42044, 	-- Relentless Gladiator's Pendant of Ascendancy
				42045, 	-- Relentless Gladiator's Pendant of Subjugation
				42046, 	-- Relentless Gladiator's Pendant of Deliverance
				42047, 	-- Relentless Gladiator's Pendant of Salvation
				42076, 	-- Relentless Gladiator's Cloak of Dominance
				42077, 	-- Relentless Gladiator's Cloak of Subjugation
				42078, 	-- Relentless Gladiator's Cloak of Ascendancy
				42079, 	-- Relentless Gladiator's Cloak of Salvation
				42080, 	-- Relentless Gladiator's Cloak of Deliverance
				42081, 	-- Relentless Gladiator's Cloak of Triumph
				42082, 	-- Relentless Gladiator's Cloak of Victory
				42118, 	-- Relentless Gladiator's Band of Ascendancy
				42119, 	-- Relentless Gladiator's Band of Victory
				46374, 	-- Relentless Gladiator's Pendant of Sundering
				49179, 	-- Relentless Gladiator's Cord of Alacrity
				49181, 	-- Relentless Gladiator's Cuffs of Alacrity
				49183, 	-- Relentless Gladiator's Treads of Alacrity
				50079, 	-- Ymirjar Lord's Gauntlets
				50081, 	-- Ymirjar Lord's Legplates
				50088, 	-- Shadowblade Gauntlets
				50090, 	-- Shadowblade Legplates
				50095, 	-- Scourgelord Gauntlets
				50097, 	-- Scourgelord Legplates
				50107, 	-- Lasherweave's Gauntlets
				50109, 	-- Lasherweave's Legplates
				50114, 	-- Ahn'Kahar Blood Hunter's Handguards
				50116, 	-- Ahn'Kahar Blood Hunter's Legguards
				50240, 	-- Dark Coven Gloves
				50242, 	-- Dark Coven Leggings
				50275, 	-- Bloodmage Gloves
				50277, 	-- Bloodmage Leggings
				50325, 	-- Lightsworn Legplates
				50327, 	-- Lightsworn Gauntlets
				50391, 	-- Crimson Acolyte Handwraps
				50393, 	-- Crimson Acolyte Pants
				50766, 	-- Crimson Acolyte Gloves
				50769, 	-- Crimson Acolyte Leggings
				50820, 	-- Lasherweave's Trousers
				50822, 	-- Lasherweave's Gloves
				50825, 	-- Lasherweave's Legguards
				50827, 	-- Lasherweave's Handgrips
				50831, 	-- Frost Witch's Grips
				50833, 	-- Frost Witch's War-Kilt
				50836, 	-- Frost Witch's Handguards
				50838, 	-- Frost Witch's Legguards
				50842, 	-- Frost Witch's Gloves
				50844, 	-- Frost Witch's Kilt
				50847, 	-- Ymirjar Lord's Legguards
				50849, 	-- Ymirjar Lord's Handguards
				50854, 	-- Scourgelord Legguards
				50856, 	-- Scourgelord Handguards
				50861, 	-- Lightsworn Legguards
				50863, 	-- Lightsworn Handguards
				50866, 	-- Lightsworn Greaves
				50868, 	-- Lightsworn Gloves
			},
			
			[L["SHORT_Archavon"].." (25)"] 	= {
				40415, 	-- Valorous Frostfire Gloves
				40417, 	-- Valorous Frostfire Leggings
				40418, 	-- Valorous Frostfire Robe
				40420, 	-- Valorous Plagueheart Gloves
				40422, 	-- Valorous Plagueheart Leggings
				40423, 	-- Valorous Plagueheart Robe
				40445, 	-- Valorous Gloves of Faith
				40448, 	-- Valorous Leggings of Faith
				40449, 	-- Valorous Robe of Faith
				40454, 	-- Valorous Handwraps of Faith
				40457, 	-- Valorous Pants of Faith
				40458, 	-- Valorous Raiments of Faith
				40460, 	-- Valorous Dreamwalker Handguards
				40462, 	-- Valorous Dreamwalker Leggings
				40463, 	-- Valorous Dreamwalker Robe
				40466, 	-- Valorous Dreamwalker Gloves
				40468, 	-- Valorous Dreamwalker Trousers
				40469, 	-- Valorous Dreamwalker Vestments
				40471, 	-- Valorous Dreamwalker Raiments
				40472, 	-- Valorous Dreamwalker Handgrips
				40493, 	-- Valorous Dreamwalker Legguards
				40495, 	-- Valorous Bonescythe Breastplate
				40496, 	-- Valorous Bonescythe Gauntlets
				40500, 	-- Valorous Bonescythe Legplates
				40503, 	-- Valorous Crypstalker Tunic
				40504, 	-- Valorous Crypstalker Handguards
				40506, 	-- Valorous Crypstalker Legguards
				40508, 	-- Valorous Earthshatter Tunic
				40509, 	-- Valorous Earthshatter Handguards
				40512, 	-- Valorous Earthshatter Legguards
				40514, 	-- Valorous Earthshatter Hauberk
				40515, 	-- Valorous Earthshatter Gloves
				40517, 	-- Valorous Earthshatter Kilt
				40520, 	-- Valorous Earthshatter Grips
				40522, 	-- Valorous Earthshatter War-Kilt
				40523, 	-- Valorous Earthshatter Chestguard
				40525, 	-- Valorous Dreadnaught Battleplate
				40527, 	-- Valorous Dreadnaught Gauntlets
				40529, 	-- Valorous Dreadnaught Legplates
				40544, 	-- Valorous Dreadnaught Breastplate
				40545, 	-- Valorous Dreadnaught Handguards
				40547, 	-- Valorous Dreadnaught Legguards
				40550, 	-- Valorous Scourgeborne Battleplate
				40552, 	-- Valorous Scourgeborne Gauntlets
				40556, 	-- Valorous Scourgeborne Legplates
				40559, 	-- Valorous Scourgeborne Chestguard
				40563, 	-- Valorous Scourgeborne Handguards
				40567, 	-- Valorous Scourgeborne Legguards
				40569, 	-- Valorous Redemption Tunic
				40570, 	-- Valorous Redemption Gloves
				40572, 	-- Valorous Redemption Greaves
				40574, 	-- Valorous Redemption Chestpiece
				40575, 	-- Valorous Redemption Gauntlets
				40577, 	-- Valorous Redemption Legplates
				40579, 	-- Valorous Redemption Breastplate
				40580, 	-- Valorous Redemption Handguards
				40583, 	-- Valorous Redemption Legguards
				40784, 	-- Deadly Gladiator's Dreadplate Chestpiece
				40785, 	-- Deadly Gladiator's Scaled Chestpiece
				40786, 	-- Deadly Gladiator's Plate Chestpiece
				40804, 	-- Deadly Gladiator's Plate Gauntlets
				40805, 	-- Deadly Gladiator's Scaled Gauntlets
				40806, 	-- Deadly Gladiator's Dreadplate Gauntlets
				40844, 	-- Deadly Gladiator's Plate Legguards
				40845, 	-- Deadly Gladiator's Dreadplate Legguards
				40846, 	-- Deadly Gladiator's Scaled Legguards
				40905, 	-- Deadly Gladiator's Ornamented Chestguard
				40926, 	-- Deadly Gladiator's Ornamented Gloves
				40938, 	-- Deadly Gladiator's Ornamented Legplates
				40990, 	-- Deadly Gladiator's Ringmail Armor
				40991, 	-- Deadly Gladiator's Mail Armor
				41000, 	-- Deadly Gladiator's Ringmail Gauntlets
				41006, 	-- Deadly Gladiator's Mail Gauntlets
				41026, 	-- Deadly Gladiator's Ringmail Leggings
				41032, 	-- Deadly Gladiator's Mail Leggings
				41080, 	-- Deadly Gladiator's Linked Armor
				41086, 	-- Deadly Gladiator's Chain Armor
				41136, 	-- Deadly Gladiator's Linked Gauntlets
				41142, 	-- Deadly Gladiator's Chain Gauntlets
				41198, 	-- Deadly Gladiator's Linked Leggings
				41204, 	-- Deadly Gladiator's Chain Leggings
				41286, 	-- Deadly Gladiator's Kodohide Gloves
				41292, 	-- Deadly Gladiator's Wyrmhide Gloves
				41297, 	-- Deadly Gladiator's Kodohide Legguards
				41303, 	-- Deadly Gladiator's Wyrmhide Legguards
				41309, 	-- Deadly Gladiator's Kodohide Robes
				41315, 	-- Deadly Gladiator's Wyrmhide Robes
				41649, 	-- Deadly Gladiator's Leather Tunic
				41654, 	-- Deadly Gladiator's Leather Legguards
				41660, 	-- Deadly Gladiator's Dragonhide Robes
				41666, 	-- Deadly Gladiator's Dragonhide Legguards
				41766, 	-- Deadly Gladiator's Leather Gloves
				41772, 	-- Deadly Gladiator's Dragonhide Gloves
				41858, 	-- Deadly Gladiator's Mooncloth Robe
				41863, 	-- Deadly Gladiator's Mooncloth Leggings
				41873, 	-- Deadly Gladiator's Mooncloth Gloves
				41920, 	-- Deadly Gladiator's Satin Robe
				41926, 	-- Deadly Gladiator's Satin Leggings
				41939, 	-- Deadly Gladiator's Satin Gloves
				41951, 	-- Deadly Gladiator's Silk Raiment
				41958, 	-- Deadly Gladiator's Silk Trousers
				41970, 	-- Deadly Gladiator's Silk Handguards
				41997, 	-- Deadly Gladiator's Felweave Raiment
				42004, 	-- Deadly Gladiator's Felweave Trousers
				42016, 	-- Deadly Gladiator's Felweave Handguards
			},
			[L["SHORT_Emalon"].." (25)"] 	= {
				40807, 	-- Furious Gladiator's Plate Gauntlets
				40808, 	-- Furious Gladiator's Scaled Gauntlets
				40809, 	-- Furious Gladiator's Dreadplate Gauntlets
				40847, 	-- Furious Gladiator's Plate Legguards
				40848, 	-- Furious Gladiator's Dreadplate Legguards
				40849, 	-- Furious Gladiator's Scaled Legguards
				40881, 	-- Furious Gladiator's Girdle of Triumph
				40882, 	-- Furious Gladiator's Greaves of Triumph
				40889, 	-- Furious Gladiator's Bracers of Triumph
				40927, 	-- Furious Gladiator's Ornamented Gloves
				40939, 	-- Furious Gladiator's Ornamented Legplates
				40976, 	-- Furious Gladiator's Girdle of Salvation
				40977, 	-- Furious Gladiator's Greaves of Salvation
				40983, 	-- Furious Gladiator's Bracers of Salvation
				41001, 	-- Furious Gladiator's Ringmail Gauntlets
				41007, 	-- Furious Gladiator's Mail Gauntlets
				41027, 	-- Furious Gladiator's Ringmail Leggings
				41033, 	-- Furious Gladiator's Mail Leggings
				41051, 	-- Furious Gladiator's Waistguard of Salvation
				41055, 	-- Furious Gladiator's Sabatons of Salvation
				41060, 	-- Furious Gladiator's Wristguards of Salvation
				41065, 	-- Furious Gladiator's Wristguards of Dominance
				41070, 	-- Furious Gladiator's Waistguard of Dominance
				41075, 	-- Furious Gladiator's Sabatons of Dominance
				41137, 	-- Furious Gladiator's Linked Gauntlets
				41143, 	-- Furious Gladiator's Chain Gauntlets
				41199, 	-- Furious Gladiator's Linked Leggings
				41205, 	-- Furious Gladiator's Chain Leggings
				41225, 	-- Furious Gladiator's Wristguards of Triumph
				41230, 	-- Furious Gladiator's Sabatons of Triumph
				41235, 	-- Furious Gladiator's Waistguard of Triumph
				41287, 	-- Furious Gladiator's Kodohide Gloves
				41293, 	-- Furious Gladiator's Wyrmhide Gloves
				41298, 	-- Furious Gladiator's Kodohide Legguards
				41304, 	-- Furious Gladiator's Wyrmhide Legguards
				41617, 	-- Furious Gladiator's Belt of Salvation
				41621, 	-- Furious Gladiator's Boots of Salvation
				41625, 	-- Furious Gladiator's Armwraps of Salvation
				41630, 	-- Furious Gladiator's Belt of Dominance
				41635, 	-- Furious Gladiator's Boots of Dominance
				41640, 	-- Furious Gladiator's Armwraps of Dominance
				41655, 	-- Furious Gladiator's Leather Legguards
				41667, 	-- Furious Gladiator's Dragonhide Legguards
				41767, 	-- Furious Gladiator's Leather Gloves
				41773, 	-- Furious Gladiator's Dragonhide Gloves
				41832, 	-- Furious Gladiator's Belt of Triumph
				41836, 	-- Furious Gladiator's Boots of Triumph
				41840, 	-- Furious Gladiator's Armwraps of Triumph
				41864, 	-- Furious Gladiator's Mooncloth Leggings
				41874, 	-- Furious Gladiator's Mooncloth Gloves
				41881, 	-- Furious Gladiator's Cord of Salvation
				41885, 	-- Furious Gladiator's Slippers of Salvation
				41893, 	-- Furious Gladiator's Cuffs of Salvation
				41898, 	-- Furious Gladiator's Cord of Dominance
				41903, 	-- Furious Gladiator's Slippers of Dominance
				41909, 	-- Furious Gladiator's Cuffs of Dominance
				41927, 	-- Furious Gladiator's Satin Leggings
				41940, 	-- Furious Gladiator's Satin Gloves
				41959, 	-- Furious Gladiator's Silk Trousers
				41971, 	-- Furious Gladiator's Silk Handguards
				42005, 	-- Furious Gladiator's Felweave Trousers
				42017, 	-- Furious Gladiator's Felweave Handguards
				42034, 	-- Furious Gladiator's Pendant of Triumph
				42035, 	-- Furious Gladiator's Pendant of Victory
				42036, 	-- Furious Gladiator's Pendant of Dominance
				42037, 	-- Furious Gladiator's Pendant of Ascendancy
				42038, 	-- Furious Gladiator's Pendant of Subjugation
				42039, 	-- Furious Gladiator's Pendant of Deliverance
				42040, 	-- Furious Gladiator's Pendant of Salvation
				42069, 	-- Furious Gladiator's Cloak of Dominance
				42070, 	-- Furious Gladiator's Cloak of Subjugation
				42071, 	-- Furious Gladiator's Cloak of Ascendancy
				42072, 	-- Furious Gladiator's Cloak of Salvation
				42073, 	-- Furious Gladiator's Cloak of Deliverance
				42074, 	-- Furious Gladiator's Cloak of Triumph
				42075, 	-- Furious Gladiator's Cloak of Victory
				42116, 	-- Furious Gladiator's Band of Dominance
				42117, 	-- Furious Gladiator's Band of Triumph
				46113, 	-- Conqueror's Darkruned Gauntlets
				46116, 	-- Conqueror's Darkruned Legplates
				46119, 	-- Conqueror's Darkruned Handguards
				46121, 	-- Conqueror's Darkruned Legguards
				46124, 	-- Conqueror's Terrorblade Gauntlets
				46126, 	-- Conqueror's Terrorblade Legplates
				46132, 	-- Conqueror's Kirin'dor Gauntlets
				46133, 	-- Conqueror's Kirin'dor Leggings
				46135, 	-- Conqueror's Deathbringer Gloves
				46139, 	-- Conqueror's Deathbringer Leggings
				46142, 	-- Conqueror's Scourgestalker Handguards
				46144, 	-- Conqueror's Scourgestalker Legguards
				46148, 	-- Conqueror's Siegebreaker Gauntlets
				46150, 	-- Conqueror's Siegebreaker Legplates
				46153, 	-- Conqueror's Aegis Legplates
				46155, 	-- Conqueror's Aegis Gauntlets
				46158, 	-- Conqueror's Nightsong Handgrips
				46160, 	-- Conqueror's Nightsong Legguards
				46163, 	-- Conqueror's Handwraps of Sanctification
				46164, 	-- Conqueror's Siegebreaker Handguards
				46169, 	-- Conqueror's Siegebreaker Legguards
				46170, 	-- Conqueror's Pants of Sanctification
				46174, 	-- Conqueror's Aegis Handguards
				46176, 	-- Conqueror's Aegis Legguards
				46179, 	-- Conqueror's Aegis Gloves
				46181, 	-- Conqueror's Aegis Greaves
				46183, 	-- Conqueror's Nightsong Handguards
				46185, 	-- Conqueror's Nightsong Leggings
				46188, 	-- Conqueror's Gloves of Sanctification
				46189, 	-- Conqueror's Nightsong Gloves
				46192, 	-- Conqueror's Nightsong Trousers
				46195, 	-- Conqueror's Leggings of Sanctification
				46199, 	-- Conqueror's Worldbreaker Handguards
				46200, 	-- Conqueror's Worldbreaker Grips
				46202, 	-- Conqueror's Worldbreaker Legguards
				46207, 	-- Conqueror's Worldbreaker Gloves
				46208, 	-- Conqueror's Worldbreaker War-Kilt
				46210, 	-- Conqueror's Worldbreaker Kilt
				46373, 	-- Furious Gladiator's Pendant of Sundering
			},
			[L["SHORT_Koralon"].." (25)"] 	= {
				40810, 	-- Relentless Gladiator's Plate Gauntlets
				40811, 	-- Relentless Gladiator's Dreadplate Gauntlets
				40812, 	-- Relentless Gladiator's Scaled Gauntlets
				40850, 	-- Relentless Gladiator's Plate Legguards
				40851, 	-- Relentless Gladiator's Dreadplate Legguards
				40852, 	-- Relentless Gladiator's Scaled Legguards
				40883, 	-- Relentless Gladiator's Girdle of Triumph
				40884, 	-- Relentless Gladiator's Greaves of Triumph
				40890, 	-- Relentless Gladiator's Bracers of Triumph
				40928, 	-- Relentless Gladiator's Ornamented Gloves
				40940, 	-- Relentless Gladiator's Ornamented Legplates
				40978, 	-- Relentless Gladiator's Girdle of Salvation
				40979, 	-- Relentless Gladiator's Greaves of Salvation
				40984, 	-- Relentless Gladiator's Bracers of Salvation
				41002, 	-- Relentless Gladiator's Ringmail Gauntlets
				41008, 	-- Relentless Gladiator's Mail Gauntlets
				41028, 	-- Relentless Gladiator's Ringmail Leggings
				41034, 	-- Relentless Gladiator's Mail Leggings
				41052, 	-- Relentless Gladiator's Waistguard of Salvation
				41056, 	-- Relentless Gladiator's Sabatons of Salvation
				41061, 	-- Relentless Gladiator's Wristguards of Salvation
				41066, 	-- Relentless Gladiator's Wristguards of Dominance
				41071, 	-- Relentless Gladiator's Waistguard of Dominance
				41076, 	-- Relentless Gladiator's Sabatons of Dominance
				41138, 	-- Relentless Gladiator's Linked Gauntlets
				41144, 	-- Relentless Gladiator's Chain Gauntlets
				41200, 	-- Relentless Gladiator's Linked Leggings
				41206, 	-- Relentless Gladiator's Chain Leggings
				41226, 	-- Relentless Gladiator's Wristguards of Triumph
				41231, 	-- Relentless Gladiator's Sabatons of Triumph
				41236, 	-- Relentless Gladiator's Waistguard of Triumph
				41288, 	-- Relentless Gladiator's Kodohide Gloves
				41294, 	-- Relentless Gladiator's Wyrmhide Gloves
				41299, 	-- Relentless Gladiator's Kodohide Legguards
				41305, 	-- Relentless Gladiator's Wyrmhide Legguards
				41618, 	-- Relentless Gladiator's Belt of Salvation
				41622, 	-- Relentless Gladiator's Boots of Salvation
				41626, 	-- Relentless Gladiator's Armwraps of Salvation
				41631, 	-- Relentless Gladiator's Belt of Dominance
				41636, 	-- Relentless Gladiator's Boots of Dominance
				41641, 	-- Relentless Gladiator's Armwraps of Dominance
				41656, 	-- Relentless Gladiator's Leather Legguards
				41668, 	-- Relentless Gladiator's Dragonhide Legguards
				41768, 	-- Relentless Gladiator's Leather Gloves
				41774, 	-- Relentless Gladiator's Dragonhide Gloves
				41833, 	-- Relentless Gladiator's Belt of Triumph
				41837, 	-- Relentless Gladiator's Boots of Triumph
				41841, 	-- Relentless Gladiator's Armwraps of Triumph
				41865, 	-- Relentless Gladiator's Mooncloth Leggings
				41875, 	-- Relentless Gladiator's Mooncloth Gloves
				41882, 	-- Relentless Gladiator's Cord of Salvation
				41886, 	-- Relentless Gladiator's Treads of Salvation
				41894, 	-- Relentless Gladiator's Cuffs of Salvation
				41899, 	-- Relentless Gladiator's Cord of Dominance
				41904, 	-- Relentless Gladiator's Treads of Dominance
				41910, 	-- Relentless Gladiator's Cuffs of Dominance
				41928, 	-- Relentless Gladiator's Satin Leggings
				41941, 	-- Relentless Gladiator's Satin Gloves
				41960, 	-- Relentless Gladiator's Silk Trousers
				41972, 	-- Relentless Gladiator's Silk Handguards
				42006, 	-- Relentless Gladiator's Felweave Trousers
				42018, 	-- Relentless Gladiator's Felweave Handguards
				42041, 	-- Relentless Gladiator's Pendant of Triumph
				42042, 	-- Relentless Gladiator's Pendant of Victory
				42043, 	-- Relentless Gladiator's Pendant of Dominance
				42044, 	-- Relentless Gladiator's Pendant of Ascendancy
				42045, 	-- Relentless Gladiator's Pendant of Subjugation
				42046, 	-- Relentless Gladiator's Pendant of Deliverance
				42047, 	-- Relentless Gladiator's Pendant of Salvation
				42076, 	-- Relentless Gladiator's Cloak of Dominance
				42077, 	-- Relentless Gladiator's Cloak of Subjugation
				42078, 	-- Relentless Gladiator's Cloak of Ascendancy
				42079, 	-- Relentless Gladiator's Cloak of Salvation
				42080, 	-- Relentless Gladiator's Cloak of Deliverance
				42081, 	-- Relentless Gladiator's Cloak of Triumph
				42082, 	-- Relentless Gladiator's Cloak of Victory
				42118, 	-- Relentless Gladiator's Band of Ascendancy
				42119, 	-- Relentless Gladiator's Band of Victory
				46374, 	-- Relentless Gladiator's Pendant of Sundering
				47753, 	-- Khadgar's Gauntlets of Triumph
				47755, 	-- Khadgar's Leggings of Triumph
				47770, 	-- Sunstrider's Leggings of Triumph
				47772, 	-- Sunstrider's Gauntlets of Triumph
				47780, 	-- Kel'Thuzad's Leggings of Triumph
				47782, 	-- Kel'Thuzad's Gloves of Triumph
				47803, 	-- Gul'dan's Gloves of Triumph
				47805, 	-- Gul'dan's Leggings of Triumph
				47983, 	-- Velen's Gloves of Triumph
				47985, 	-- Velen's Leggings of Triumph
				48064, 	-- Zabra's Leggings of Triumph
				48066, 	-- Zabra's Gloves of Triumph
				48077, 	-- Velen's Handwraps of Triumph
				48079, 	-- Velen's Pants of Triumph
				48094, 	-- Zabra's Pants of Triumph
				48096, 	-- Zabra's Handwraps of Triumph
				48133, 	-- Stormrage's Handguards of Triumph
				48135, 	-- Stormrage's Leggings of Triumph
				48150, 	-- Runetotem's Leggings of Triumph
				48152, 	-- Runetotem's Handguards of Triumph
				48163, 	-- Stormrage's Gloves of Triumph
				48165, 	-- Stormrage's Trousers of Triumph
				48180, 	-- Runetotem's Trousers of Triumph
				48182, 	-- Runetotem's Gloves of Triumph
				48193, 	-- Runetotem's Handgrips of Triumph
				48195, 	-- Runetotem's Legguards of Triumph
				48210, 	-- Stormrage's Legguards of Triumph
				48212, 	-- Stormrage's Handgrips of Triumph
				48224, 	-- VanCleef's Gauntlets of Triumph
				48226, 	-- VanCleef's Legplates of Triumph
				48239, 	-- Garona's Legplates of Triumph
				48241, 	-- Garona's Gauntlets of Triumph
				48256, 	-- Windrunner's Handguards of Triumph
				48258, 	-- Windrunner's Legguards of Triumph
				48271, 	-- Windrunner's Legguards of Triumph
				48273, 	-- Windrunner's Handguards of Triumph
				48286, 	-- Nobundo's Handguards of Triumph
				48288, 	-- Nobundo's Legguards of Triumph
				48301, 	-- Thrall's Handguards of Triumph
				48303, 	-- Thrall's Legguards of Triumph
				48317, 	-- Nobundo's Gloves of Triumph
				48319, 	-- Nobundo's Kilt of Triumph
				48332, 	-- Thrall's Kilt of Triumph
				48334, 	-- Thrall's Gloves of Triumph
				48347, 	-- Nobundo's Grips of Triumph
				48349, 	-- Nobundo's War-Kilt of Triumph
				48362, 	-- Thrall's War-Kilt of Triumph
				48364, 	-- Thrall's Grips of Triumph
				48377, 	-- Wrynn's Gauntlets of Triumph
				48379, 	-- Wrynn's Legplates of Triumph
				48392, 	-- Hellscream's Gauntlets of Triumph
				48394, 	-- Hellscream's Legplates of Triumph
				48446, 	-- Wrynn's Legguards of Triumph
				48452, 	-- Wrynn's Handguards of Triumph
				48462, 	-- Hellscream's Handguards of Triumph
				48464, 	-- Hellscream's Legguards of Triumph
				48482, 	-- Thassarian's Gauntlets of Triumph
				48484, 	-- Thassarian's Legplates of Triumph
				48497, 	-- Koltira's Legplates of Triumph
				48499, 	-- Koltira's Gauntlets of Triumph
				48539, 	-- Thassarian's Handguards of Triumph
				48541, 	-- Thassarian's Legguards of Triumph
				48554, 	-- Koltira's Legguards of Triumph
				48556, 	-- Koltira's Handguards of Triumph
				48576, 	-- Turalyon's Gloves of Triumph
				48578, 	-- Turalyon's Greaves of Triumph
				48591, 	-- Liadrin's Greaves of Triumph
				48593, 	-- Liadrin's Gloves of Triumph
				48608, 	-- Turalyon's Gauntlets of Triumph
				48610, 	-- Turalyon's Legplates of Triumph
				48623, 	-- Liadrin's Legplates of Triumph
				48625, 	-- Liadrin's Gauntlets of Triumph
				48638, 	-- Turalyon's Legguards of Triumph
				48640, 	-- Turalyon's Handguards of Triumph
				48658, 	-- Liadrin's Handguards of Triumph
				48660, 	-- Liadrin's Legguards of Triumph
				49179, 	-- Relentless Gladiator's Cord of Alacrity
				49181, 	-- Relentless Gladiator's Cuffs of Alacrity
				49183, 	-- Relentless Gladiator's Treads of Alacrity
			},
			[L["SHORT_Toravon"].." (25)"] 	= {
				51126, 	-- Sanctified Scourgelord Legplates
				51128, 	-- Sanctified Scourgelord Gauntlets
				51131, 	-- Sanctified Scourgelord Legguards
				51132, 	-- Sanctified Scourgelord Handguards
				51136, 	-- Sanctified Lasherweave's Legplates
				51138, 	-- Sanctified Lasherweave's Gauntlets
				51142, 	-- Sanctified Lasherweave's Legguards
				51144, 	-- Sanctified Lasherweave's Handgrips
				51146, 	-- Sanctified Lasherweave's Trousers
				51148, 	-- Sanctified Lasherweave's Gloves
				51152, 	-- Sanctified Ahn'Kahar Blood Hunter's Legguards
				51154, 	-- Sanctified Ahn'Kahar Blood Hunter's Handguards
				51157, 	-- Sanctified Bloodmage Leggings
				51159, 	-- Sanctified Bloodmage Gloves
				51161, 	-- Sanctified Lightsworn Legplates
				51163, 	-- Sanctified Lightsworn Gauntlets
				51168, 	-- Sanctified Lightsworn Greaves
				51169, 	-- Sanctified Lightsworn Gloves
				51171, 	-- Sanctified Lightsworn Legguards
				51172, 	-- Sanctified Lightsworn Handguards
				51177, 	-- Sanctified Crimson Acolyte Leggings
				51179, 	-- Sanctified Crimson Acolyte Gloves
				51181, 	-- Sanctified Crimson Acolyte Pants
				51183, 	-- Sanctified Crimson Acolyte Handwraps
				51186, 	-- Sanctified Shadowblade Legplates
				51188, 	-- Sanctified Shadowblade Gauntlets
				51191, 	-- Sanctified Frost Witch's Handguards
				51193, 	-- Sanctified Frost Witch's Legguards
				51196, 	-- Sanctified Frost Witch's Grips
				51198, 	-- Sanctified Frost Witch's War-Kilt
				51201, 	-- Sanctified Frost Witch's Gloves
				51203, 	-- Sanctified Frost Witch's Kilt
				51207, 	-- Sanctified Dark Coven Leggings
				51209, 	-- Sanctified Dark Coven Gloves
				51211, 	-- Ymirjar Lord's Legplates
				51213, 	-- Ymirjar Lord's Gauntlets
				51216, 	-- Ymirjar Lord's Legguards
				51217, 	-- Ymirjar Lord's Handguards
				51327, 	-- Wrathful Gladiator's Cord of Dominance
				51328, 	-- Wrathful Gladiator's Treads of Dominance
				51329, 	-- Wrathful Gladiator's Cuffs of Dominance
				51330, 	-- Wrathful Gladiator's Cloak of Dominance
				51331, 	-- Wrathful Gladiator's Pendant of Dominance
				51332, 	-- Wrathful Gladiator's Cloak of Subjugation
				51333, 	-- Wrathful Gladiator's Pendant of Subjugation
				51334, 	-- Wrathful Gladiator's Cloak of Ascendancy
				51335, 	-- Wrathful Gladiator's Pendant of Ascendancy
				51336, 	-- Wrathful Gladiator's Band of Dominance
				51337, 	-- Wrathful Gladiator's Cord of Alacrity
				51338, 	-- Wrathful Gladiator's Treads of Alacrity
				51339, 	-- Wrathful Gladiator's Cuffs of Alacrity
				51340, 	-- Wrathful Gladiator's Belt of Salvation
				51341, 	-- Wrathful Gladiator's Boots of Salvation
				51342, 	-- Wrathful Gladiator's Armwraps of Salvation
				51343, 	-- Wrathful Gladiator's Belt of Dominance
				51344, 	-- Wrathful Gladiator's Boots of Dominance
				51345, 	-- Wrathful Gladiator's Armwraps of Dominance
				51346, 	-- Wrathful Gladiator's Cloak of Salvation
				51347, 	-- Wrathful Gladiator's Pendant of Salvation
				51348, 	-- Wrathful Gladiator's Cloak of Deliverance
				51349, 	-- Wrathful Gladiator's Pendant of Deliverance
				51350, 	-- Wrathful Gladiator's Waistguard of Triumph
				51351, 	-- Wrathful Gladiator's Sabatons of Triumph
				51352, 	-- Wrathful Gladiator's Wristguards of Triumph
				51353, 	-- Wrathful Gladiator's Pendant of Sundering
				51354, 	-- Wrathful Gladiator's Cloak of Triumph
				51355, 	-- Wrathful Gladiator's Pendant of Triumph
				51356, 	-- Wrathful Gladiator's Cloak of Victory
				51357, 	-- Wrathful Gladiator's Pendant of Victory
				51358, 	-- Wrathful Gladiator's Band of Triumph
				51359, 	-- Wrathful Gladiator's Girdle of Salvation
				51360, 	-- Wrathful Gladiator's Greaves of Salvation
				51361, 	-- Wrathful Gladiator's Bracers of Salvation
				51362, 	-- Wrathful Gladiator's Girdle of Triumph
				51363, 	-- Wrathful Gladiator's Greaves of Triumph
				51364, 	-- Wrathful Gladiator's Bracers of Triumph
				51365, 	-- Wrathful Gladiator's Cord of Salvation
				51366, 	-- Wrathful Gladiator's Treads of Salvation
				51367, 	-- Wrathful Gladiator's Cuffs of Salvation
				51368, 	-- Wrathful Gladiator's Belt of Triumph
				51369, 	-- Wrathful Gladiator's Boots of Triumph
				51370, 	-- Wrathful Gladiator's Armwraps of Triumph
				51371, 	-- Wrathful Gladiator's Waistguard of Salvation
				51372, 	-- Wrathful Gladiator's Sabatons of Salvation
				51373, 	-- Wrathful Gladiator's Wristguards of Salvation
				51374, 	-- Wrathful Gladiator's Waistguard of Dominance
				51375, 	-- Wrathful Gladiator's Sabatons of Dominance
				51376, 	-- Wrathful Gladiator's Wristguards of Dominance
				51414, 	-- Wrathful Gladiator's Dreadplate Gauntlets
				51416, 	-- Wrathful Gladiator's Dreadplate Legguards
				51420, 	-- Wrathful Gladiator's Kodohide Gloves
				51422, 	-- Wrathful Gladiator's Kodohide Legguards
				51426, 	-- Wrathful Gladiator's Dragonhide Gloves
				51428, 	-- Wrathful Gladiator's Dragonhide Legguards
				51434, 	-- Wrathful Gladiator's Wyrmhide Gloves
				51436, 	-- Wrathful Gladiator's Wyrmhide Legguards
				51459, 	-- Wrathful Gladiator's Chain Gauntlets
				51461, 	-- Wrathful Gladiator's Chain Leggings
				51464, 	-- Wrathful Gladiator's Silk Handguards
				51466, 	-- Wrathful Gladiator's Silk Trousers
				51469, 	-- Wrathful Gladiator's Ornamented Gloves
				51471, 	-- Wrathful Gladiator's Ornamented Legplates
				51475, 	-- Wrathful Gladiator's Scaled Gauntlets
				51477, 	-- Wrathful Gladiator's Scaled Legguards
				51483, 	-- Wrathful Gladiator's Mooncloth Gloves
				51485, 	-- Wrathful Gladiator's Mooncloth Leggings
				51488, 	-- Wrathful Gladiator's Satin Gloves
				51490, 	-- Wrathful Gladiator's Satin Leggings
				51493, 	-- Wrathful Gladiator's Leather Gloves
				51495, 	-- Wrathful Gladiator's Leather Legguards
				51498, 	-- Wrathful Gladiator's Ringmail Gauntlets
				51500, 	-- Wrathful Gladiator's Ringmail Leggings
				51504, 	-- Wrathful Gladiator's Linked Gauntlets
				51506, 	-- Wrathful Gladiator's Linked Leggings
				51510, 	-- Wrathful Gladiator's Mail Gauntlets
				51512, 	-- Wrathful Gladiator's Mail Leggings
				51537, 	-- Wrathful Gladiator's Felweave Handguards
				51539, 	-- Wrathful Gladiator's Felweave Trousers
				51542, 	-- Wrathful Gladiator's Plate Gauntlets
				51544, 	-- Wrathful Gladiator's Plate Legguards
			},
		},
		
		
		[BZ["Ulduar"] ] = {
			[L["Patterns"]] 	= { 45088, 45089, 45090, 45091, 45092, 45093, 45094, 45095, 45096, 45097, 45098, 45099, 45100, 45101, 45102, 45103, 45104, 45105, 46027, 46348 },
			[BB["Freya"]] 	= { 46110 },
		},
		[BZ["Ulduar"] .. " (10)"] = {
			[BB["Flame Leviathan"]] = {
				45289, 45291, 45288, 45283, 45285, 45292, 45286, 45284, 45287, 45282,
			},
			[BB["Flame Leviathan"] .. " (HM)"] = {
				45293, 45300, 45295, 45297, 45296, 
			},
			[BB["Razorscale"]] = {
				45306, 45302, 45301, 45307, 45299, 45305, 45304, 45303, 45308, 45298, 
			},
			[BB["Ignis the Furnace Master"]] = {
				45317, 45318, 45312, 45316, 45321, 45310, 45313, 45314, 45311, 45309, 
			},
			[BB["XT-002 Deconstructor"]] = {
				45694, 45677, 45686, 45687, 45679, 45676, 45680, 45675, 45685, 45682, 
			},
			[BB["XT-002 Deconstructor"] .. " (HM)"] = {
				45869, 45867, 45871, 45868, 45870, 
			},
			[BB["The Iron Council"]] = {
				45322, 45423, 45324, 45378, 45329, 45333, 45330, 45418, 45332, 45331, 
			},
			[BB["The Iron Council"] .. " (HM)"] = {
				45455, 45447, 45456, 45449, 45448, 45506, 
			},
			[BB["Kologarn"]] = {
				45704, 45701, 45697, 45698, 45696, 45699, 45702, 45703, 45700, 45695, 
			},
			[BB["Algalon the Observer"]] = {
				46042, 46045, 46050, 46043, 46049, 46044, 46037, 46039, 46041, 46047, 46040, 46048, 46046, 46038, 46051, 46052, 
			},
			[BB["Auriaya"]] = {
				45832, 45865, 45864, 45709, 45711, 45712, 45708, 45866, 45707, 45713, 
			},
			[BB["Hodir"]] = {
				45873, 45464, 45874, 45458, 45872, 45650, 45651, 45652, 
			},
			[BB["Hodir"] .. " (HM)"] = {
				45888, 45876, 45886, 45887, 45877, 45786, 
			},
			[BB["Thorim"]] = {
				45893, 45927, 45894, 45895, 45892, 45659, 45660, 45661, 
			},
			[BB["Thorim"] .. " (HM)"] = {
				45928, 45933, 45931, 45929, 45930, 45784, 
			},
			[BB["Freya"]] = {
				45940, 45941, 45935, 45936, 45934, 45644, 45645, 45646, 
			},
			[BB["Freya"] .. " (HM)"] = {
				45943, 45945, 45946, 45947, 45294, 45788, 
			},
			[BB["Mimiron"]] = {
				45973, 45976, 45974, 45975, 45972, 45647, 45648, 45649, 
			},
			[BB["Mimiron"] .. " (HM)"] = {
				45993, 45989, 45982, 45988, 45990, 45787, 
			},
			[BB["General Vezax"]] = {
				46014, 46013, 46012, 46009, 45997, 46008, 46015, 46010, 46011, 45996, 
			},
			[BB["General Vezax"] .. " (HM)"] = {
				46032, 46034, 46036, 46035, 46033, 
			},
			[BB["Yogg-Saron"]] = {
				46030, 46019, 46028, 46022, 46021, 46024, 46016, 46031, 46025, 46018, 45635, 45636, 45637, 
			},
			[BB["Yogg-Saron"] .. " (HM+1)"] = {
				46068, 46095, 46096, 46097, 46067 },
			[BB["Yogg-Saron"] .. " (HM+0)"] = { 46312 },
			[L["Trash Mobs"]] = {
				46341, 46347, 46344, 46346, 46345, 46340, 46343, 46339, 46351, 46350, 46342, 
			},
		},
		[BZ["Ulduar"] .. " (25)"] = {
			[BB["Flame Leviathan"]] = {
				45117, 45119, 45108, 45118, 45109, 45107, 45111, 45116, 45113, 45106, 45112, 45115, 45114, 45110, 45086, 
			},
			[BB["Flame Leviathan"] .. " (HM)"] = {
				45135, 45136, 45134, 45133, 45132, 
			},
			[BB["Razorscale"]] = {
				45138, 45150, 45146, 45149, 45141, 45151, 45143, 45140, 45139, 45148, 45510, 45144, 45142, 45147, 45137, 
			},
			[BB["Ignis the Furnace Master"]] = {
				45186, 45185, 45162, 45164, 45187, 45167, 45161, 45166, 45157, 45168, 45158, 45169, 45165, 45171, 45170, 
			},
			[BB["XT-002 Deconstructor"]] = {
				45253, 45258, 45260, 45259, 45249, 45251, 45252, 45248, 45250, 45247, 45254, 45255, 45246, 45256, 45257, 
			},
			[BB["XT-002 Deconstructor"] .. " (HM)"] = {
				45446, 45444, 45445, 45443, 45442, 
			},
			[BB["The Iron Council"]] = {
				45224, 45240, 45238, 45237, 45232, 45227, 45239, 45226, 45225, 45228, 45193, 45236, 45235, 45233, 45234, 
			},
			[BB["The Iron Council"] .. " (HM)"] = {
				45242, 45245, 45244, 45241, 45243, 45607, 45857, 
			},
			[BB["Kologarn"]] = {
				45272, 45275, 45273, 45265, 45274, 45264, 45269, 45268, 45267, 45262, 45263, 45271, 45270, 45266, 45261, 
			},
			[BB["Algalon the Observer"]] = {
				45665, 45619, 45611, 45616, 45610, 45615, 45594, 45599, 45617, 45620, 45607, 45612, 45613, 45587, 45570, 45609, 46053, 
			},
			[BB["Auriaya"]] = {
				45319, 45435, 45441, 45439, 45325, 45440, 45320, 45334, 45434, 45326, 45438, 45436, 45437, 45315, 45327, 
			},
			[BB["Hodir"]] = {
				45453, 45454, 45452, 45451, 45450, 45632, 45633, 45634, 
			},
			[BB["Hodir"] .. " (HM)"] = {
				45461, 45462, 45460, 45459, 45612, 45457, 45815, 
			},
			[BB["Thorim"]] = {
				45468, 45467, 45469, 45466, 45463, 45638, 45639, 45640, 
			},
			[BB["Thorim"] .. " (HM)"] = {
				45473, 45474, 45472, 45471, 45570, 45470, 45817, 
			},
			[BB["Freya"]] = {
				45483, 45482, 45481, 45480, 45479, 45653, 45654, 45655, 
			},
			[BB["Freya"] .. " (HM)"] = {
				45486, 45488, 45487, 45485, 45484, 45613, 45814, 
			},
			[BB["Mimiron"]] = {
				45493, 45492, 45491, 45490, 45489, 45641, 45642, 45643, 
			},
			[BB["Mimiron"] .. " (HM)"] = {
				45496, 45497, 45663, 45495, 45494, 45620, 45816, 
			},
			[BB["General Vezax"]] = {
				45514, 45508, 45512, 45504, 45513, 45502, 45505, 45501, 45503, 45515, 45507, 45509, 45145, 45498, 45511, 
			},
			[BB["General Vezax"] .. " (HM)"] = {
				45520, 45519, 45517, 45518, 45516, 
			},
			[BB["Yogg-Saron"]] = {
				45529, 45532, 45523, 45524, 45531, 45525, 45530, 45522, 45527, 45521, 45656, 45657, 45658, 
			},
			[BB["Yogg-Saron"] .. " (HM+1)"] = {
				45537, 45536, 45534, 45535, 45533, 
			},
			[BB["Yogg-Saron"] .. " (HM+0)"] = { 45693, },
			[L["Trash Mobs"]] = {
				45541, 45549, 45547, 45548, 45543, 45544, 45542, 45540, 45539, 45538, 46138, 45605, 
			},
		},
		
		
		[BZ["Onyxia's Lair"]] = {
			[BB["Onyxia"].." (10)"] = {
				49307, 49316, 49317, 49315, 49318, 49322, 49327, 49328, 49326, 49331,
				49330, 49329, 49319, 49320, 49321, 49333, 49332, 49323, 49325, 49324,
				49306, 49309, 49463, 49310, 49308, 49304, 49437, 49298, 49303, 49296, 
				49299, 49297, 49302, 49301, 49305,
			},
			[BB["Onyxia"].." (25)"] = {
				49491, 49482, 49483, 49484, 49481, 49477, 49472, 49473, 49471, 49469,
				49468, 49470, 49480, 49479, 49478, 49467, 49466, 49476, 49475, 49474,
				49492, 49489, 49464, 49488, 49490, 49494, 49465, 49499, 49495, 49501,
				49498, 49500, 49496, 49497, 49493, 
			},
			[BB["Onyxia"]] = { 49294, 49295, 49636, 49643, 49644, },
			[L["Quest rewards"]] = { 49485, 49486, 49487, },
		},
		
		[BZ["Trial of the Champion"]] = {
			[BB["Faction Champions"]] = {	47173, 47170, 47174, 47175, 47172, 47171, },
			["Argent Champion Encounter"] = {	47176, 47177, 47178, 47181, 47185, 47213, },
			[BB["Argent Confessor Paletress"]] = {	47218, 47217, 47211, 47212, 47219, 47214, },
			[BB["Eadric the Pure"]] = { 47210, 47202, 47197, 47201, 47199, 47200, },
			[BB["The Black Knight"]] = { 47232, 47226, 47230, 47221, 47231, 47228, 47220, 47229, 47227, 47222, 47215, 47216, },
		},
		[BZ["Trial of the Champion"] .. L[" (Heroic)"]] = {
			[BB["Faction Champions"]] = { 47249, 47248, 47250, 47244, 47243, 47493, },
			["Argent Champion Encounter"] = { 47494, 47495, 47496, 47497, 47498, 47500, },
			[BB["Argent Confessor Paletress"]] = { 47245, 47514, 47510, 47511, 47512, 47522, },
			[BB["Eadric the Pure"]] = { 47501, 47504, 47502, 47503, 47509, 47508, },
			[BB["The Black Knight"]] = { 47564, 47527, 47560, 47529, 47561, 47563, 47565, 47567, 47562, 47566, 47569, 49682, 47568, 48418, },
		},
		
		[BZ["Trial of the Crusader"] ] = {
			[L["Patterns"]] = { 
				47654, 47655, 47656, 47657, 47629, 47635, 47631, 47630, 47628, 47634,
				47632, 47633, 47622, 47623, 47627, 47626, 47624, 47625, 47639, 47638, 
				47637, 47636, 47646, 47647, 47648, 47649, 47650, 47651, 47652, 47653, 
				47640, 47641, 47642, 47643, 47644, 47645, },
			[L["Miscellaneous"]] = { 47242, },
		},
		[BZ["Trial of the Crusader"] .. " (10)"] = {
			[BB["The Beasts of Northrend"]] = {	47617, 47613, 47608, 47616, 47610, 47611, 47609, 47615, 47614, 47607,
					47578, 47612, 47855, 47857, 47853, 47860, 47850, 47852, 47851, 47859, 47858, 47849,	47854, 47856 },
			[BB["Lord Jaraxxus"]] = { 47663, 47620, 47669, 47621, 49235, 47683, 47680, 47711, 47619, 47679,
					47618, 47703, 47676, 47861, 47865, 47863, 47866, 49236, 47867, 47869, 
					47870, 47872, 47864, 47862, 47868, 47871 },
			[BB["Faction Champions"]] = { 47721, 47719, 47718, 47717, 47720, 47728, 47727, 47726, 47725, 47724,
					47873, 47878, 47875, 47876, 47877, 47880, 47882, 47879, 47881, 47874	},
			[BB["The Twin Val'kyr"]] = { 47745, 49231, 47746, 47739, 47744, 47738, 47747, 47700, 47742, 47736,
					47737, 47743, 47740, 47889, 49232, 47891, 47887, 47893, 47885, 47890, 
					47888, 47913, 47886, 47884, 47892, 47883 },
			[BB["Anub'arak"]] = { 47838, 47837, 47832, 47813, 47829, 47811, 47836, 47830, 47810, 47814,
					47808, 47809, 47816, 47834, 47815, 47835, 47812, 47741, 47906, 47909, 
					47904, 47897, 47901, 47896, 47902, 47908, 47899, 47903, 47898, 47894,
					47905, 47911, 47900, 47910, 47895, 47907 },
		},
		[BZ["Trial of the Crusader"] .. " (25)"] = {
			[BB["The Beasts of Northrend"]] = {	46970, 46976, 46992, 46972, 46974, 46988, 46960, 46990, 46962, 46961,
					46985, 46959, 46979, 46958, 46963, 47257, 47256, 47264, 47258, 47259, 47262, 47251, 47265,
					47254, 47253, 47263, 47252, 47261, 47255, 47260 },
			[BB["Lord Jaraxxus"]] = { 47042, 47051, 47000, 47055, 47056, 46999, 47057, 47052, 46997, 47043,
					47223, 47041, 47053, 46996, 46994, 47275, 47274, 47270, 47277, 
					47280, 47268, 47279, 47273, 47269, 47272, 47278, 47271, 47276, 47266,
					47267 },
			[BB["Faction Champions"]] = {	47089, 47081, 47092, 47094, 47071, 47073, 47083, 47090, 47082, 47093,
					47072, 47070, 47080, 47069, 47079, 47291, 47286, 47293, 47292, 
					47284, 47281, 47289, 47295, 47288, 47294, 47283, 47282, 47290, 47285,
					47287 },
			[BB["The Twin Val'kyr"]] = { 47126, 47141, 47107, 47140, 47106, 47142, 47108, 47121, 47116, 47105,
					47139, 47115, 47138, 47104, 47114, 47301, 47306, 47308, 47299, 
					47296, 47310, 47298, 47304, 47307, 47305, 47297, 47303, 47309, 47300,
					47302	},
			[BB["Anub'arak"]] = { 47225, 47183, 47203, 47235, 47187, 47194, 47151, 47186, 47204, 47152,
					47184, 47234, 47195, 47150, 47054, 47149, 47182, 47148, 47193, 47233,
					47328, 47320, 47324, 47326, 47317, 47321, 47313, 47318, 47325, 
					47311, 47319, 47330, 47323, 47312, 47315, 47327, 47316, 47314, 47322,
					47329	},
		},
		
		[BZ["Trial of the Crusader"] .. " (10 HC)"] = {
			[BB["The Beasts of Northrend"]] = {	47921, 47923, 47919, 47926, 47916, 47918, 47917, 47924, 47925, 47915,
					47920, 47922, 47994, 47996, 47992, 47999, 47989, 47991, 47990, 47998, 
					47997, 47988, 47993, 47995 },
			[BB["Lord Jaraxxus"]] = { 47927, 47931, 47929, 47932, 49238, 47933, 47935, 47937, 47930, 47939,
					47928, 47934, 47938, 48000, 48004, 48002, 48005, 49237, 48006, 48008, 
					48009, 48011, 48003, 48001, 48007, 48010 },
			[BB["Faction Champions"]] = {	47940, 47945, 47942, 47943, 47944, 47947, 47949, 47946, 47948, 47941,
					48012, 48017, 48014, 48015, 48016, 48019, 48021, 48018, 48020, 48013 },
			[BB["The Twin Val'kyr"]] = { 47956, 49234, 47959, 47954, 47961, 47952, 47957, 47955, 47958, 47953,
					47951, 47960, 47950, 48028, 49233, 48034, 48026, 48038, 48024, 48030, 
					48027, 48032, 48025, 48023, 48036, 48022 },
			[BB["Anub'arak"]] = { 47974, 47977, 47972, 47965, 47969, 47964, 47976, 47970, 47967, 47971,
					47966, 47962, 47973, 47979, 47968, 47978, 47963, 47975, 48051, 48054, 
					48049, 48042, 48046, 48041, 48047, 48053, 48044, 48048, 48043, 48039,
					48050, 48056, 48045, 48055, 48040, 48052 },
			[L["Tribute Run"]] = { 48712, 48708, 48713, 48709, 48714, 48710, 48711, 48673,
					48675, 48674, 48671, 48672, 49044, 48703, 48701, 48695, 48693, 
					48699, 48705, 48697, 48668, 48669, 48670, 48666, 48667, 49046 },
		},
		[BZ["Trial of the Crusader"] .. " (25 HC)"] = {
			[BB["The Beasts of Northrend"]] = {	46971, 46977, 46993, 46973, 46975, 46989, 46965, 46991, 46968, 46967,
					46986, 46966, 46980, 46969, 46964, 47418, 47417, 47425, 47419, 
					47420, 47423, 47412, 47426, 47415, 47414, 47424, 47413, 47422, 47416,
					47421 },
			[BB["Lord Jaraxxus"]] = { 47063, 47062, 47004, 47066, 47068, 47002, 47067, 47061, 47003, 47060,
					47224, 47059, 47064, 47001, 46995, 47436, 47435, 47431, 47438, 
					47441, 47429, 47440, 47434, 47430, 47433, 47439, 47432, 47437, 47427,
					47428	},
			[BB["Faction Champions"]] = {	47095, 47084, 47097, 47096, 47077, 47074, 47087, 47099, 47086, 47098,
					47076, 47075, 47088, 47078, 47085, 47452, 47447, 47454, 47453, 
					47445, 47442, 47450, 47456, 47449, 47455, 47444, 47443, 47451, 47446,
					47448 },
			[BB["The Twin Val'kyr"]] = { 47129, 47143, 47112, 47145, 47109, 47147, 47111, 47132, 47133, 47110,
					47144, 47131, 47146, 47113, 47130, 47462, 47467, 47469, 47460, 
					47457, 47471, 47459, 47465, 47468, 47466, 47458, 47464, 47470, 47461,
					47463	},
			[BB["Anub'arak"]] = { 47238, 47192, 47208, 47236, 47189, 47205, 47155, 47190, 47209, 47153,
					47191, 47240, 47207, 47154, 47237, 47157, 47188, 47156, 47206, 47239,
					47490, 47481, 47485, 47487, 47478, 47482, 47474, 47479, 47486, 
					47472, 47480, 47492, 47484, 47473, 47476, 47489, 47477, 47475, 47483,
					47491 },
			[L["Tribute Run"]] = { 
				47557, 47558, 47559, -- regalias
			},
			[L["Tribute Run"] .. " (25)"] = { 
				47506,  -- Silverwing Defender
				47513,  -- Ogrim's Deflector
				47515,  -- Decimation
				47516,  -- Fleshrender
				47517,  -- Blade of the Unbroken Covenant
				47518,  -- Mortalis
				47519,  -- Catastrophe
				47520,  -- Grievance
				47521,  -- BRK-1000
				47523,  -- Fezzik's Autocannon
				47524,  -- Clemency
				47525,  -- Sufferance
				47526,  -- Remorseless
				47528,  -- Cudgel of the Damned
			},
			[L["Tribute Run"] .. " (50)"] = { 
				47545,  -- Vereesas Geschicklichkeit
				47546,  -- Sylvanas' List
				47547,  -- Varians Furor
				47548,  -- Garroshs Wut
				47549,  -- Magnis Ratschluss
				47550,  -- Cairnes Belastbarkeit
				47551,  -- Aethas' Intensität
				47552,  -- Jainas Strahlen
				47553,  -- Bolvars Hingabe
				47554,  -- Lady Liadrins Schuldspruch
			},
		},
		
		-- 3.3

		[BZ["The Forge of Souls"]] = {
			[BB["Bronjahm"]] = {	49788, 49785, 49786, 49787, 49784, 49783, 50317, 50316 },
			[BB["Devourer of Souls"]] = {	49792, 49796, 49798, 49791, 49797, 49794, 49795, 49799, 49800, 49789, 49790, 49793 },
		},
		[BZ["The Forge of Souls"] .. L[" (Heroic)"]] = {
			[BB["Bronjahm"]] = {	50193, 50197, 50194, 50196, 50191, 50169 },
			[BB["Devourer of Souls"]] = {	50213, 50206, 50212, 50214, 50209, 50208, 50207, 50215, 50211, 50198, 50203, 50210 },
		},
		[BZ["Pit of Saron"]] = {
			[BB["Forgemaster Garfrost"]] = {	49805, 49806, 49804, 49803, 49802, 49801 },
			[BB["Krick and Ick"]] = { 49807, 49808, 49809, 49810, 49811, 49812 },
			[BB["Scourgelord Tyrannus"]] = { 49823, 49825, 49822, 49817, 49824, 49826, 49820, 49819, 49816, 49818, 49821, 49813, },
		},
		[BZ["Pit of Saron"] .. L[" (Heroic)"]] = {
			[BB["Forgemaster Garfrost"]] = {	50233, 50234, 50230, 50229, 50228, 50227 },
			[BB["Krick and Ick"]] = { 50235, 50262, 50263, 50264, 50265, 50266 },
			[BB["Scourgelord Tyrannus"]] = { 50286, 50269, 50270, 50283, 50272, 50285, 50284, 50271, 50259, 50268, 50267, 50273 },
		},
		[BZ["Halls of Reflection"]] = {
			[BB["Falric"]] = { 49832, 49828, 49830, 49831, 49829, 49827 },
			[BB["Marwyn"]] = { 49834, 49838, 49837, 49836, 49833, 49835 },
			[BB["The Lich King"]] = { 49842, 49849, 49848, 49841, 49847, 49851, 49843, 49846, 49839, 49840, 49845, 49844, },
		},
		[BZ["Halls of Reflection"] .. L[" (Heroic)"]] = {
			[BB["Falric"]] = { 50292, 50293, 50295, 50294, 50290, 50291 },
			[BB["Marwyn"]] = { 50298, 50299, 50300, 50297, 50260, 50296 },
			[BB["The Lich King"]] = { 50314, 50312, 50308, 50304, 50311, 50305, 50310, 50313, 50306, 50309, 50302, 50303 },
		},
		[format("ICC %s", BUG_CATEGORY3)] = {
			[L["Trash Mobs"]] = { 49854, 49855, 49853, 49852, },
		},
		[format("ICC %s (%s)", BUG_CATEGORY3, PLAYER_DIFFICULTY2)] = {
			[L["Trash Mobs"]] = { 50318, 50315, 50319, 50380, 50379, },
		},
		[L["Battered Hilt"]] = {
			[L["Quest rewards"]] = { 50046, 50047, 50048, 50049, 50050, 50051, 50052, },
		},
		
		[ BZ["Icecrown Citadel"] ] = {
			[ L["Trash Mobs"] ] = {
				50449, 	-- Stiffened Corpse Shoulderpads
				50450, 	-- Leggings of Dubious Charms
				50451, 	-- Belt of the Lonely Noble
				50452, 	-- Wodin's Lucky Necklace
				50447, 	-- Harbinger's Bone Band
				50453, 	-- Ring of Rotting Sinew
				50444, 	-- Rowan's Rifle of Silver Bullets
			},
		},
		[ BZ["Icecrown Citadel"] .. " (10)" ] = {
			[ BB["Lord Marrowgar"] ] = {
				50764, 	-- Shawl of Nerubian Silk
				50773, 	-- Cord of the Patronizing Practitioner
				50774, 	-- Coldwraith Bracers
				50762, 	-- Linked Scourge Vertebrae
				50775, 	-- Corrupted Silverplate Leggings
				50772, 	-- Ancient Skeletal Boots
				50763, 	-- Marrowgar's Scratching Choker
				50339, 	-- Sliver of Pure Ice
				50771, 	-- Frost Needle
				50761, 	-- Citadel Enforcer's Claymore
				50759, 	-- Bone Warden's Splitter
				50760, 	-- Bonebreaker Scepter
			},
			[ BB["Lady Deathwhisper"] ] = {
				50785, 	-- Bracers of Dark Blessings
				50782, 	-- Sister's Handshrouds
				50780, 	-- Chestguard of the Frigid Noose
				50778, 	-- Soulthief's Braided Belt
				50783, 	-- Boots of the Frozen Seed
				50777, 	-- Handgrips of Frost and Sleet
				50784, 	-- Deathspeaker Disciple's Belt
				50779, 	-- Deathspeaker Zealot's Helm
				50786, 	-- Ghoul Commander's Cuirass
				50342, 	-- Whispering Fanged Skull
				50781, 	-- Scourgelord's Baton
				50776, 	-- Njordnar Bone Bow
			},			
			[ L["Gunship"] ] = {
				50791, 	-- Saronite Gargoyle Cloak
				50795, 	-- Cord of Dark Suffering
				50797, 	-- Ice-Reinforced Vrykul Helm
				50792, 	-- Pauldrons of Lost Hope
				50789, 	-- Icecrown Rampart Bracers
				50796, 	-- Bracers of Pale Illumination
				50788, 	-- Bone Drake's Enameled Boots
				50790, 	-- Abomination's Bloody Ring
				50340, 	-- Muradin's Spyglass
				50793, 	-- Midnight Sun
				50787, 	-- Frost Giant's Cleaver
				50794, 	-- Neverending Winter
			},
			[ BB["Deathbringer Saurfang"] ] = {
				50807, 	-- Thaumaturge's Crackling Cowl
				50804, 	-- Icecrown Spire Sandals
				50799, 	-- Scourge Stranglers
				50806, 	-- Leggings of Unrelenting Blood
				50800, 	-- Hauberk of a Thousand Cuts
				50801, 	-- Blade-Scored Carapace
				50802, 	-- Gargoyle Spit Bracers
				50808, 	-- Deathforged Legplates
				50809, 	-- Soulcleave Pendant
				50803, 	-- Saurfang's Cold-Forged Band
				50798, 	-- Ramaladni's Blade of Culling
				50805, 	-- Mag'hari Chieftain's Staff
			},
			[ BB["Festergut"] ] = {
				50859, 	-- Cloak of Many Skins
				50988, 	-- Bloodstained Surgeon's Shoulderguards
				50990, 	-- Kilt of Untreated Wounds
				50985, 	-- Wrists of Septic Shock
				50858, 	-- Plague-Soaked Leather Leggings
				50812, 	-- Taldron's Long Neglected Boots
				50967, 	-- Festergut's Gaseous Gloves
				50811, 	-- Festering Fingerguards
				50852, 	-- Precious's Putrid Collar
				50986, 	-- Signet of Putrefaction
				50810, 	-- Gutbuster
				50966, 	-- Abracadaver
			},
			[ BB["Rotface"] ] = {
				51007, 	-- Ether-Soaked Bracers
				51005, 	-- Gloves of Broken Fingers
				51009, 	-- Chestguard of the Failed Experiment
				51002, 	-- Taldron's Short-Sighted Helm
				51006, 	-- Shuffling Shoes
				51000, 	-- Flesh-Shaper's Gurney Strap
				51008, 	-- Choker of Filthy Diamonds
				51001, 	-- Rotface's Rupturing Ring
				51003, 	-- Abomination Knuckles
				51004, 	-- Lockjaw
				50998, 	-- Shaft of Glacial Ice
				50999, 	-- Gluth's Fetching Knife
			},
			[ BB["Professor Putricide"] ] = {
				51020, 	-- Shoulders of Ruinous Senility
				51017, 	-- Cauterized Cord
				51013, 	-- Discarded Bag of Entrails
				51015, 	-- Shoulderpads of the Morbid Ritual
				51019, 	-- Rippling Flesh Kilt
				51014, 	-- Scalpel-Sharpening Shoulderguards
				51018, 	-- Chestplate of Septic Stitches
				51012, 	-- Infected Choker
				51016, 	-- Pendant of Split Veins
				50341, 	-- Unidentifiable Organ
				51011, 	-- Flesh-Carving Scalpel
				51010, 	-- The Facelifter
			},
			[ BB["Blood Prince Council"] ] = {
				51382, 	-- Heartsick Mender's Cape
				51379, 	-- Bloodsoul Raiment
				51380, 	-- Pale Corpse Boots
				51023, 	-- Taldaram's Soft Slippers
				51325, 	-- Blood-Drinker's Girdle
				51383, 	-- Spaulders of the Blood Princes
				51025, 	-- Battle-Maiden's Legguards
				51381, 	-- Cerise Coiled Ring
				51024, 	-- Thrice Fanged Signet
				51021, 	-- Soulbreaker
				51022, 	-- Hersir's Greatspear
				51326, 	-- Wand of Ruby Claret
			},
			[ BB["Blood-Queen Lana'thel"] ] = {
				51554, 	-- Cowl of Malefic Repose
				51552, 	-- Shoulderpads of the Searing Kiss
				51550, 	-- Ivory-Inlaid Leggings
				51551, 	-- Chestguard of Siphoned Elements
				51386, 	-- Throatrender Handguards
				51556, 	-- Veincrusher Gauntlets
				51555, 	-- Tightening Waistband
				51548, 	-- Collar of Haughty Disdain
				51387, 	-- Seal of the Twilight Queen
				51384, 	-- Bloodsipper
				51385, 	-- Stakethrower
				51553, 	-- Lana'thel's Bloody Nail
			},
			[ BB["Valithria Dreamwalker"] ] = {
				51584, 	-- Lich Wrappings
				51777, 	-- Leggings of the Refracted Mind
				51585, 	-- Sister Svalna's Spangenhelm
				51565, 	-- Skinned Whelp Shoulders
				51583, 	-- Stormbringer Gloves
				51566, 	-- Legguards of the Twisted Dream
				51586, 	-- Emerald Saint's Spaulders
				51563, 	-- Taiga Bindings
				51564, 	-- Ironrope Belt of Ymirjar
				51562, 	-- Oxheart
				51582, 	-- Sister Svalna's Aether Staff
				51561, 	-- Dreamhunter's Carbine
			},
			[ BB["Sindragosa"] ] = {
				51790, 	-- Robes of Azure Downfall
				51783, 	-- Vambraces of the Frost Wyrm Queen
				51789, 	-- Icicle Shapers
				51792, 	-- Shoulderguards of Crystalline Bone
				51785, 	-- Wyrmwing Treads
				51782, 	-- Etched Dragonbone Girdle
				51786, 	-- Legplates of Aetheric Strife
				51787, 	-- Scourge Fanged Stompers
				51779, 	-- Rimetooth Pendant
				51784, 	-- Splintershard
				51788, 	-- Bleak Coldarra Carver
				51791, 	-- Lost Pavise of the Blue Flight
			},
			[ BB["The Lich King"] ] = {
				51801, 	-- Pugius, Fist of Defiance
				51803, 	-- Tel'thas, Dagger of the Blood King
				51800, 	-- Stormfury, Black Blade of the Betrayer
				51795, 	-- Troggbane, Axe of the Frostborne King
				51798, 	-- Valius, Gavel of the Lightbringer
				51796, 	-- Warmace of Menethil
				51799, 	-- Halion, Staff of Forgotten Love
				51797, 	-- Tainted Twig of Nordrassil
				51802, 	-- Windrunner's Heartseeker
			},
		},
		[ BZ["Icecrown Citadel"] .. " (10 HC)" ] = {
			[BB["Lord Marrowgar"]] = {
				51933, 	-- Shawl of Nerubian Silk
				51930, 	-- Cord of the Patronizing Practitioner
				51929, 	-- Coldwraith Bracers
				51935, 	-- Linked Scourge Vertebrae
				51928, 	-- Corrupted Silverplate Leggings
				51931, 	-- Ancient Skeletal Boots
				51934, 	-- Marrowgar's Scratching Choker
				50346, 	-- Sliver of Pure Ice
				51932, 	-- Frost Needle
				51936, 	-- Citadel Enforcer's Claymore
				51938, 	-- Bone Warden's Splitter
				51937, 	-- Bonebreaker Scepter
			},
			[BB["Lady Deathwhisper"]] = {
				51918, 	-- Bracers of Dark Blessings
				51921, 	-- Sister's Handshrouds
				51923, 	-- Chestguard of the Frigid Noose
				51925, 	-- Soulthief's Braided Belt
				51920, 	-- Boots of the Frozen Seed
				51926, 	-- Handgrips of Frost and Sleet
				51919, 	-- Deathspeaker Disciple's Belt
				51924, 	-- Deathspeaker Zealot's Helm
				51917, 	-- Ghoul Commander's Cuirass
				50343, 	-- Whispering Fanged Skull
				51922, 	-- Scourgelord's Baton
				51927, 	-- Njordnar Bone Bow
			},
			[L["Gunship"]] = {
				51912, 	-- Saronite Gargoyle Cloak
				51908, 	-- Cord of Dark Suffering
				51906, 	-- Ice-Reinforced Vrykul Helm
				51911, 	-- Pauldrons of Lost Hope
				51914, 	-- Icecrown Rampart Bracers
				51907, 	-- Bracers of Pale Illumination
				51915, 	-- Bone Drake's Enameled Boots
				51913, 	-- Abomination's Bloody Ring
				50345, 	-- Muradin's Spyglass
				51910, 	-- Midnight Sun
				51916, 	-- Frost Giant's Cleaver
				51909, 	-- Neverending Winter
			},
			[BB["Deathbringer Saurfang"]] = {
				51896, 	-- Thaumaturge's Crackling Cowl
				51899, 	-- Icecrown Spire Sandals
				51904, 	-- Scourge Stranglers
				51897, 	-- Leggings of Unrelenting Blood
				51903, 	-- Hauberk of a Thousand Cuts
				51902, 	-- Blade-Scored Carapace
				51901, 	-- Gargoyle Spit Bracers
				51895, 	-- Deathforged Legplates
				51894, 	-- Soulcleave Pendant
				51900, 	-- Saurfang's Cold-Forged Band
				51905, 	-- Ramaladni's Blade of Culling
				51898, 	-- Mag'hari Chieftain's Staff
			},
			[BB["Festergut"]] = {
				51888, 	-- Cloak of Many Skins
				51883, 	-- Bloodstained Surgeon's Shoulderguards
				51882, 	-- Kilt of Untreated Wounds
				51885, 	-- Wrists of Septic Shock
				51889, 	-- Plague-Soaked Leather Leggings
				51891, 	-- Taldron's Long Neglected Boots
				51886, 	-- Festergut's Gaseous Gloves
				51892, 	-- Festering Fingerguards
				51890, 	-- Precious's Putrid Collar
				51884, 	-- Signet of Putrefaction
				51893, 	-- Gutbuster
				51887, 	-- Abracadaver
			},
			[BB["Rotface"]] = {
				51872, 	-- Ether-Soaked Bracers
				51874, 	-- Gloves of Broken Fingers
				51870, 	-- Chestguard of the Failed Experiment
				51877, 	-- Taldron's Short-Sighted Helm
				51873, 	-- Shuffling Shoes
				51879, 	-- Flesh-Shaper's Gurney Strap
				51871, 	-- Choker of Filthy Diamonds
				51878, 	-- Rotface's Rupturing Ring
				51876, 	-- Abomination Knuckles
				51875, 	-- Lockjaw
				51881, 	-- Shaft of Glacial Ice
				51880, 	-- Gluth's Fetching Knife
			},
			[BB["Professor Putricide"]] = {
				51859, 	-- Shoulders of Ruinous Senility
				51862, 	-- Cauterized Cord
				51866, 	-- Discarded Bag of Entrails
				51864, 	-- Shoulderpads of the Morbid Ritual
				51860, 	-- Rippling Flesh Kilt
				51865, 	-- Scalpel-Sharpening Shoulderguards
				51861, 	-- Chestplate of Septic Stitches
				51867, 	-- Infected Choker
				51863, 	-- Pendant of Split Veins
				50344, 	-- Unidentifiable Organ
				51868, 	-- Flesh-Carving Scalpel
				51869, 	-- The Facelifter
			},
			[BB["Blood Prince Council"]] = {
				51848, 	-- Heartsick Mender's Cape
				51851, 	-- Bloodsoul Raiment
				51850, 	-- Pale Corpse Boots
				51856, 	-- Taldaram's Soft Slippers
				51853, 	-- Blood-Drinker's Girdle
				51847, 	-- Spaulders of the Blood Princes
				51854, 	-- Battle-Maiden's Legguards
				51849, 	-- Cerise Coiled Ring
				51855, 	-- Thrice Fanged Signet
				51858, 	-- Soulbreaker
				51857, 	-- Hersir's Greatspear
				51852, 	-- Wand of Ruby Claret
			},
			[BB["Blood-Queen Lana'thel"]] = {
				51837, 	-- Cowl of Malefic Repose
				51839, 	-- Shoulderpads of the Searing Kiss
				51841, 	-- Ivory-Inlaid Leggings
				51840, 	-- Chestguard of Siphoned Elements
				51844, 	-- Throatrender Handguards
				51835, 	-- Veincrusher Gauntlets
				51836, 	-- Tightening Waistband
				51842, 	-- Collar of Haughty Disdain
				51843, 	-- Seal of the Twilight Queen
				51846, 	-- Bloodsipper
				51845, 	-- Stakethrower
				51838, 	-- Lana'thel's Bloody Nail
			},
			[BB["Valithria Dreamwalker"]] = {
				51826, 	-- Lich Wrappings
				51823, 	-- Leggings of the Refracted Mind
				51825, 	-- Sister Svalna's Spangenhelm
				51830, 	-- Skinned Whelp Shoulders
				51827, 	-- Stormbringer Gloves
				51829, 	-- Legguards of the Twisted Dream
				51824, 	-- Emerald Saint's Spaulders
				51832, 	-- Taiga Bindings
				51831, 	-- Ironrope Belt of Ymirjar
				51833, 	-- Oxheart
				51828, 	-- Sister Svalna's Aether Staff
				51834, 	-- Dreamhunter's Carbine
			},
			[BB["Sindragosa"]] = {
				51813, 	-- Robes of Azure Downfall
				51820, 	-- Vambraces of the Frost Wyrm Queen
				51814, 	-- Icicle Shapers
				51811, 	-- Shoulderguards of Crystalline Bone
				51818, 	-- Wyrmwing Treads
				51821, 	-- Etched Dragonbone Girdle
				51817, 	-- Legplates of Aetheric Strife
				51816, 	-- Scourge Fanged Stompers
				51822, 	-- Rimetooth Pendant
				51819, 	-- Splintershard
				51815, 	-- Bleak Coldarra Carver
				51812, 	-- Lost Pavise of the Blue Flight
			},
			[BB["The Lich King"]] = {
				51941, 	-- Pugius, Fist of Defiance
				51939, 	-- Tel'thas, Dagger of the Blood King
				51942, 	-- Stormfury, Black Blade of the Betrayer
				51947, 	-- Troggbane, Axe of the Frostborne King
				51944, 	-- Valius, Gavel of the Lightbringer
				51946, 	-- Warmace of Menethil
				51943, 	-- Halion, Staff of Forgotten Love
				51945, 	-- Tainted Twig of Nordrassil
				51940, 	-- Windrunner's Heartseeker
			},
		},
		[ BZ["Icecrown Citadel"] .. " (25)" ] = {
			[ L["Quest rewards"] ] = {
				49888, 	-- Shadow's Edge
				49623, 	-- Shadowmourne
				51316, 	-- Unsealed Chest (Shadowmourne Quest)
				51317, 	-- Alexandros' Soul Shard (Unsealed Chest)
				51318, 	-- Jaina's Locket (Unsealed Chest)
				51319, 	-- Arthas' Training Sword (Unsealed Chest)
				51320, 	-- Badge of the Silver Hand (Unsealed Chest)
				51321, 	-- Blood of Sylvanas (Unsealed Chest)
				52200, 	-- Reins of the Crimson Deathcharger (Unsealed Chest Quest)
				52201, 	-- Muradin's Favor (Unsealed Chest Quest)
				52251, 	-- Jaina's Locket (Unsealed Chest Quest)
				52252, 	-- Tabard of the Lightbringer (Unsealed Chest Quest)
				52253, 	-- Sylvanas's Music Box (Unsealed Chest Quest)
			},
			[ BOSS ] = {
				50274, 	-- Shadowfrost Shard
			},
			[ format("%s-%s", L["Quarter_Wing"], BOSS) ] = {
				52025, 	-- Druide, Magier, Schurke, Todesritter
				52026, 	-- Jäger, Krieger, Schamane
				52027, 	-- Hexenmeister, Paladin, Priester
			},
			[ BB["Lord Marrowgar"] ] = {
				49978, 	-- Crushing Coldwraith Belt
				49979, 	-- Handguards of Winter's Respite
				49950, 	-- Frostbitten Fur Boots
				49952, 	-- Snowserpent Mail Helm
				49980, 	-- Rusted Bonespike Pauldrons
				49951, 	-- Gendarme's Cuirass
				49960, 	-- Bracers of Dark Reckoning
				49964, 	-- Legguards of Lost Hope
				49975, 	-- Bone Sentinel's Amulet
				49949, 	-- Band of the Bone Colossus
				49977, 	-- Loop of the Endless Labyrinth
				49967, 	-- Marrowgar's Frigid Eye
				49968, 	-- Frozen Bonespike
				50415, 	-- Bryntroll, the Bone Arbiter
				49976, 	-- Bulwark of Smouldering Steel
			},
			[ BB["Lady Deathwhisper"] ] = {
				49991, 	-- Shoulders of Mercy Killing
				49994, 	-- The Lady's Brittle Bracers
				49987, 	-- Cultist's Bloodsoaked Spaulders
				49996, 	-- Deathwhisper Chestpiece
				49988, 	-- Leggings of Northern Lights
				49993, 	-- Necrophotic Greaves
				49986, 	-- Broken Ram Skull Helm
				49995, 	-- Fallen Lord's Handguards
				49983, 	-- Blood-Soaked Saronite Stompers
				49989, 	-- Ahn'kahar Onyx Neckguard
				49985, 	-- Juggernaut Band
				49990, 	-- Ring of Maddening Whispers
				49982, 	-- Heartpierce
				49992, 	-- Nibelung
				50034, 	-- Zod's Repeating Longbow
			},
			[ L["Gunship"] ] = {
				49998, 	-- Shadowvault Slayer's Cloak
				50006, 	-- Corp'rethar Ceremonial Crown
				50011, 	-- Gunship Captain's Mittens
				50001, 	-- Ikfirus's Sack of Wonder
				50009, 	-- Boots of Unnatural Growth
				50000, 	-- Scourge Hunter's Vambraces
				50003, 	-- Boneguard Commander's Pauldrons
				50002, 	-- Polar Bear Claw Bracers
				50010, 	-- Waistband of Righteous Fury
				50005, 	-- Amulet of the Silent Eulogy
				50008, 	-- Ring of Rapid Ascent
				49999, 	-- Skeleton Lord's Circle
				50359, 	-- Althor's Abacus
				50352, 	-- Corpse Tongue Coin
				50411, 	-- Scourgeborne Waraxe
			},
			[ BB["Deathbringer Saurfang"] ] = {
				50014, 	-- Greatcloak of the Turned Champion
				50333, 	-- Toskk's Maximized Wristguards
				50015, 	-- Belt of the Blood Nova
				50362, 	-- Deathbringer's Will
				50412, 	-- Bloodvenom Blade
			},
			[ BB["Festergut"] ] = {
				50063, 	-- Lingering Illness
				50056, 	-- Plaguebringer's Stained Pants
				50062, 	-- Plague Scientist's Boots
				50042, 	-- Gangrenous Leggings
				50041, 	-- Leather of Stitched Scourge Parts
				50059, 	-- Horrific Flesh Epaulets
				50038, 	-- Carapace of Forgotten Kings
				50064, 	-- Unclean Surgical Gloves
				50413, 	-- Nerub'ar Stalker's Cord
				50060, 	-- Faceplate of the Forgotten
				50037, 	-- Fleshrending Gauntlets
				50036, 	-- Belt of Broken Bones
				50061, 	-- Holiday's Grace
				50414, 	-- Might of Blight
				50035, 	-- Black Bruise
				50040, 	-- Distant Land
				50226, 	-- Festergut's Acidic Blood
			},
			[ BB["Rotface"] ] = {
				50019, 	-- Winding Sheet
				50032, 	-- Death Surgeon's Sleeves
				50026, 	-- Helm of the Elder Moon
				50021, 	-- Aldriana's Gloves of Secrecy
				50022, 	-- Dual-Bladed Pauldrons
				50030, 	-- Bloodsunder's Bracers
				50020, 	-- Raging Behemoth's Shoulderplates
				50024, 	-- Blightborne Warplate
				50027, 	-- Rot-Resistant Breastplate
				50023, 	-- Bile-Encrusted Medallion
				50025, 	-- Seal of Many Mouths
				50353, 	-- Dislodged Foreign Object
				50028, 	-- Trauma
				50016, 	-- Rib Spreader
				50033, 	-- Corpse-Impaling Spike
				50231, 	-- Rotface's Acidic Blood
			},
			[ BB["Professor Putricide"] ] = {
				50067, 	-- Astrylian's Sutured Cinch
				50069, 	-- Professor's Bloodied Smock
				50351, 	-- Tiny Abomination in a Jar
				50179, 	-- Last Word
				50068, 	-- Rigormortis
			},
			[ BB["Blood Prince Council"] ] = {
				50074, 	-- Royal Crimson Cloak
				50172, 	-- Sanguine Silk Robes
				50176, 	-- San'layn Ritualist Gloves
				50073, 	-- Geistlord's Punishment Sack
				50171, 	-- Shoulders of Frost-Tipped Thorns
				50177, 	-- Mail of Crimson Coins
				50071, 	-- Treads of the Wasteland
				50072, 	-- Landsoul's Horned Greathelm
				50175, 	-- Crypt Keeper's Bracers
				50075, 	-- Taldaram's Plated Fists
				50174, 	-- Incarnadine Band of Mending
				50170, 	-- Valanar's Other Signet Ring
				50173, 	-- Shadow Silk Spindle
				50184, 	-- Keleseth's Seducer
				49919, 	-- Cryptmaker
			},
			[ BB["Blood-Queen Lana'thel"] ] = {
				50182, 	-- Blood Queen's Crimson Choker
				50180, 	-- Lana'thel's Chain of Flagellation
				50354, 	-- Bauble of True Blood
				50178, 	-- Bloodfall
				50181, 	-- Dying Light
				50065, 	-- Icecrown Glacial Wall
			},
			[ BB["Valithria Dreamwalker"] ] = {
				50205, 	-- Frostbinder's Shredded Cape
				50418, 	-- Robe of the Waking Nightmare
				50417, 	-- Bracers of Eternal Dreaming
				50202, 	-- Snowstorm Helm
				50188, 	-- Anub'ar Stalker's Gloves
				50187, 	-- Coldwraith Links
				50199, 	-- Leggings of Dying Candles
				50192, 	-- Scourge Reaver's Legplates
				50416, 	-- Boots of the Funeral March
				50190, 	-- Grinning Skull Greatboots
				50195, 	-- Noose of Malachite
				50185, 	-- Devium's Eternally Cold Ring
				50186, 	-- Frostbrood Sapphire Ring
				50183, 	-- Lungbreaker
				50472, 	-- Nightmare Ender
			},
			[ BB["Sindragosa"] ] = {
				50421, 	-- Sindragosa's Cruel Claw
				50424, 	-- Memory of Malygos
				50360, 	-- Phylactery of the Nameless Lich
				50361, 	-- Sindragosa's Flawless Fang
				50423, 	-- Sundial of Eternal Dusk
			},
			[ BB["The Lich King"] ] = {
				50426, 	-- Heaven's Fall, Kryss of a Thousand Lies
				50427, 	-- Bloodsurge, Kel'Thuzad's Blade of Agony
				50070, 	-- Glorenzelg, High-Blade of the Silver Hand
				50012, 	-- Havoc's Call, Blade of Lordaeron Kings
				50428, 	-- Royal Scepter of Terenas II
				49997, 	-- Mithrios, Bronzebeard's Legacy
				50425, 	-- Oathbinder, Charge of the Ranger-General
				50429, 	-- Archus, Greatstaff of Antonidas
				49981, 	-- Fal'inrush, Defender of Quel'thalas
				51315, 	-- Sealed Chest (Shadowmourne Quest)
			},
		},
		[ BZ["Icecrown Citadel"] .. " (25 HC)" ] = {
			[ format("%s-%s", L["Quarter_Wing"], BOSS) ] = {
				52028, 	-- hc, Druide, Magier, Schurke, Todesritter
				52029, 	-- hc, Jäger, Krieger, Schamane
				52030, 	-- hc, Hexenmeister, Paladin, Priester
			},
			[BB["Lord Marrowgar"]] = {
				50613, 	-- Crushing Coldwraith Belt
				50615, 	-- Handguards of Winter's Respite
				50607, 	-- Frostbitten Fur Boots
				50605, 	-- Snowserpent Mail Helm
				50617, 	-- Rusted Bonespike Pauldrons
				50606, 	-- Gendarme's Cuirass
				50611, 	-- Bracers of Dark Reckoning
				50612, 	-- Legguards of Lost Hope
				50609, 	-- Bone Sentinel's Amulet
				50604, 	-- Band of the Bone Colossus
				50614, 	-- Loop of the Endless Labyrinth
				50610, 	-- Marrowgar's Frigid Eye
				50608, 	-- Frozen Bonespike
				50709, 	-- Bryntroll, the Bone Arbiter
				50616, 	-- Bulwark of Smouldering Steel
			},
			[BB["Lady Deathwhisper"]] = {
				50643, 	-- Shoulders of Mercy Killing
				50651, 	-- The Lady's Brittle Bracers
				50646, 	-- Cultist's Bloodsoaked Spaulders
				50649, 	-- Deathwhisper Chestpiece
				50645, 	-- Leggings of Northern Lights
				50652, 	-- Necrophotic Greaves
				50640, 	-- Broken Ram Skull Helm
				50650, 	-- Fallen Lord's Handguards
				50639, 	-- Blood-Soaked Saronite Stompers
				50647, 	-- Ahn'kahar Onyx Neckguard
				50642, 	-- Juggernaut Band
				50644, 	-- Ring of Maddening Whispers
				50641, 	-- Heartpierce
				50648, 	-- Nibelung
				50638, 	-- Zod's Repeating Longbow
			},
			[L["Gunship"]] = {
				50653, 	-- Shadowvault Slayer's Cloak
				50661, 	-- Corp'rethar Ceremonial Crown
				50663, 	-- Gunship Captain's Mittens
				50656, 	-- Ikfirus's Sack of Wonder
				50665, 	-- Boots of Unnatural Growth
				50655, 	-- Scourge Hunter's Vambraces
				50660, 	-- Boneguard Commander's Pauldrons
				50659, 	-- Polar Bear Claw Bracers
				50667, 	-- Waistband of Righteous Fury
				50658, 	-- Amulet of the Silent Eulogy
				50664, 	-- Ring of Rapid Ascent
				50657, 	-- Skeleton Lord's Circle
				50366, 	-- Althor's Abacus
				50349, 	-- Corpse Tongue Coin
				50654, 	-- Scourgeborne Waraxe
			},
			[BB["Deathbringer Saurfang"]] = {
				50668, 	-- Greatcloak of the Turned Champion
				50670, 	-- Toskk's Maximized Wristguards
				50671, 	-- Belt of the Blood Nova
				50363, 	-- Deathbringer's Will
				50672, 	-- Bloodvenom Blade
			},
			[BB["Festergut"]] = {
				50702, 	-- Lingering Illness
				50694, 	-- Plaguebringer's Stained Pants
				50699, 	-- Plague Scientist's Boots
				50697, 	-- Gangrenous Leggings
				50696, 	-- Leather of Stitched Scourge Parts
				50698, 	-- Horrific Flesh Epaulets
				50689, 	-- Carapace of Forgotten Kings
				50703, 	-- Unclean Surgical Gloves
				50688, 	-- Nerub'ar Stalker's Cord
				50701, 	-- Faceplate of the Forgotten
				50690, 	-- Fleshrending Gauntlets
				50691, 	-- Belt of Broken Bones
				50700, 	-- Holiday's Grace
				50693, 	-- Might of Blight
				50692, 	-- Black Bruise
				50695, 	-- Distant Land
			},
			[BB["Rotface"]] = {
				50677, 	-- Winding Sheet
				50686, 	-- Death Surgeon's Sleeves
				50679, 	-- Helm of the Elder Moon
				50675, 	-- Aldriana's Gloves of Secrecy
				50673, 	-- Dual-Bladed Pauldrons
				50687, 	-- Bloodsunder's Bracers
				50674, 	-- Raging Behemoth's Shoulderplates
				50681, 	-- Blightborne Warplate
				50680, 	-- Rot-Resistant Breastplate
				50682, 	-- Bile-Encrusted Medallion
				50678, 	-- Seal of Many Mouths
				50348, 	-- Dislodged Foreign Object
				50685, 	-- Trauma
				50676, 	-- Rib Spreader
				50684, 	-- Corpse-Impaling Spike
			},
			[BB["Professor Putricide"]] = {
				50707, 	-- Astrylian's Sutured Cinch
				50705, 	-- Professor's Bloodied Smock
				50706, 	-- Tiny Abomination in a Jar
				50708, 	-- Last Word
				50704, 	-- Rigormortis
			},
			[BB["Blood Prince Council"]] = {
				50718, 	-- Royal Crimson Cloak
				50717, 	-- Sanguine Silk Robes
				50722, 	-- San'layn Ritualist Gloves
				50713, 	-- Geistlord's Punishment Sack
				50715, 	-- Shoulders of Frost-Tipped Thorns
				50723, 	-- Mail of Crimson Coins
				50711, 	-- Treads of the Wasteland
				50712, 	-- Landsoul's Horned Greathelm
				50716, 	-- Taldaram's Plated Fists
				50721, 	-- Crypt Keeper's Bracers
				50720, 	-- Incarnadine Band of Mending
				50714, 	-- Valanar's Other Signet Ring
				50719, 	-- Shadow Silk Spindle
				50710, 	-- Keleseth's Seducer
				50603, 	-- Cryptmaker
			},
			[BB["Blood-Queen Lana'thel"]] = {
				50724, 	-- Blood Queen's Crimson Choker
				50728, 	-- Lana'thel's Chain of Flagellation
				50726, 	-- Bauble of True Blood
				50727, 	-- Bloodfall
				50725, 	-- Dying Light
				50729, 	-- Icecrown Glacial Wall
			},
			[BB["Valithria Dreamwalker"]] = {
				50628, 	-- Frostbinder's Shredded Cape
				50629, 	-- Robe of the Waking Nightmare
				50630, 	-- Bracers of Eternal Dreaming
				50626, 	-- Snowstorm Helm
				50619, 	-- Anub'ar Stalker's Gloves
				50620, 	-- Coldwraith Links
				50623, 	-- Leggings of Dying Candles
				50624, 	-- Scourge Reaver's Legplates
				50632, 	-- Boots of the Funeral March
				50625, 	-- Grinning Skull Greatboots
				50627, 	-- Noose of Malachite
				50622, 	-- Devium's Eternally Cold Ring
				50618, 	-- Frostbrood Sapphire Ring
				50621, 	-- Lungbreaker
				50631, 	-- Nightmare Ender
			},
			[BB["Sindragosa"]] = {
				50633, 	-- Sindragosa's Cruel Claw
				50636, 	-- Memory of Malygos
				50365, 	-- Phylactery of the Nameless Lich
				50364, 	-- Sindragosa's Flawless Fang
				50635, 	-- Sundial of Eternal Dusk
			},
			[BB["The Lich King"]] = {
				50736, 	-- Heaven's Fall, Kryss of a Thousand Lies
				50732, 	-- Bloodsurge, Kel'Thuzad's Blade of Agony
				50730, 	-- Glorenzelg, High-Blade of the Silver Hand
				50737, 	-- Havoc's Call, Blade of Lordaeron Kings
				50734, 	-- Royal Scepter of Terenas II
				50738, 	-- Mithrios, Bronzebeard's Legacy
				50735, 	-- Oathbinder, Charge of the Ranger-General
				50731, 	-- Archus, Greatstaff of Antonidas
				50733, 	-- Fal'inrush, Defender of Quel'thalas
				50818, 	-- Invincible's Reins
			},
		},
		
		[ BZ["The Ruby Sanctum"] .. " (10)" ] = {
			[BB["Halion"]] = {
				53103,  -- Baltharus' Gift
				53110,  -- Zarithrian's Offering
				53111,  -- Scion's Treads
				53112,  -- Bracers of the Heir
				53113,  -- Twilight Scale Shoulders
				53114,  -- Gloaming Sark
				53115,  -- Abduction's Cover
				53116,  -- Saviana's Tribute
				53117,  -- Changeling Gloves
				53118,  -- Misbegotten Belt
				53119,  -- Boots of Divided Being
				53121,  -- Surrogate Belt
			},
		},
		[ BZ["The Ruby Sanctum"] .. " (10 HC)" ] = {
			[BB["Halion"]] = {
				54556,  -- Abduction's Cover (hc)
				54557,  -- Baltharus' Gift (hc)
				54558,  -- Boots of Divided Being (hc)
				54559,  -- Bracers of the Heir (hc)
				54560,  -- Changeling Gloves (hc)
				54561,  -- Gloaming Sark (hc)
				54562,  -- Misbegotten Belt (hc)
				54563,  -- Saviana's Tribute (hc)
				54564,  -- Scion's Treads (hc)
				54565,  -- Surrogate Belt (hc)
				54566,  -- Twilight Scale Shoulders (hc)
				54567,  -- Zarithrian's Offering (hc)
			},
		},
		[ BZ["The Ruby Sanctum"] .. " (25)" ] = {
			[BB["Halion"]] = {
				53125,  -- Apocalypse's Advance
				53126,  -- Umbrage Armbands
				53127,  -- Returning Footfalls
				53129,  -- Treads of Impending Resurrection
				53132,  -- Penumbra Pendant
				53133,  -- Signet of Twilight
				53134,  -- Phaseshifter's Bracers
				53486,  -- Bracers of Fiery Night
				53487,  -- Foreshadow Steps
				53488,  -- Split Shape Belt
				53489,  -- Cloak of Burning Dusk
				53490,  -- Ring of Phased Regeneration
				54569,  -- Sharpened Twilight Scale
				54571,  -- Petrified Twilight Scale
				54572,  -- Charred Twilight Scale
				54573,  -- Glowing Twilight Scale
			},
		},
		[ BZ["The Ruby Sanctum"] .. " (25 HC)" ] = {
			[BB["Halion"]] = {
				54576,  -- Signet of Twilight (hc)
				54577,  -- Returning Footfalls (hc)
				54578,  -- Apocalypse's Advance (hc)
				54579,  -- Treads of Impending Resurrection (hc)
				54580,  -- Umbrage Armbands (hc)
				54581,  -- Penumbra Pendant (hc)
				54582,  -- Bracers of Fiery Night (hc)
				54583,  -- Cloak of Burning Dusk (hc)
				54584,  -- Phaseshifter's Bracers (hc)
				54585,  -- Ring of Phased Regeneration (hc)
				54586,  -- Foreshadow Steps (hc)
				54587,  -- Split Shape Belt (hc)
				54588,  -- Charred Twilight Scale (hc)
				54589,  -- Glowing Twilight Scale (hc)
				54590,  -- Sharpened Twilight Scale (hc)
				54591,  -- Petrified Twilight Scale (hc)
			},
		},
		
	}

	lootTableRev = {}
	
	local lastZone = {}
	
	local lootTable_names = {}
	for zName, _ in pairs(lootTable) do
		tinsert( lootTable_names, zName )
	end
	sort(lootTable_names)
	local zTable
	
	for _, zName in pairs(lootTable_names) do
		zTable = lootTable[zName]
		for encounterName, encounterTable in pairs(zTable) do 
			for _, item_id in pairs(encounterTable) do 
				if not lootTableRev[item_id] then
					lootTableRev[item_id] = format("%s, %s", zName, encounterName)
				else
					if lastZone[item_id] and lastZone[item_id] == zName then
						lootTableRev[item_id] = format("%s/ %s", lootTableRev[item_id], encounterName)
					else
						lootTableRev[item_id] = format("%s; %s, %s", lootTableRev[item_id], zName, encounterName)
					end
				end
				
				lastZone[item_id] = zName
			end
		end
	end
	
	DEBUG_HELP_TEST_1 = lootTableRev
	DEBUG_HELP_TEST_2 = lootTable
	wipe(lastZone)
	wipe(lootTable_names)
end

local DataProviders

addon.Loots = {}

local ns = addon.Loots		-- ns = namespace

function ns:GetSource(searchedID)
	DataProviders = DataProviders or {			-- list of sources that have a :GetSource() method
		DataStore_Reputations,
		DataStore_Crafts,
		DataStore_Inventory,
	}
	
	-- extremely fast: takes from 0.3 to 3 ms max, depends on the location of the item in the table (obviously longer if the item is at the end)
	for Instance, BossList in pairs(lootTable) do
		for Boss, LootList in pairs(BossList) do
			for itemID, _ in pairs(LootList) do
				if LootList[itemID] == searchedID then
					return Instance, Boss
				end
			end
		end
	end

	local domain, subDomain
	for _, provider in pairs(DataProviders) do
		domain, subDomain = provider:GetSource(searchedID)
		if domain and subDomain then
			return domain, subDomain
		end
	end
	
	return nil
end

local filters = addon.ItemFilters

local function ParseAltoholicLoots(OnMatch, OnNoMatch)
	assert(type(OnMatch) == "function")
	local count = 0
	
	for Instance, BossList in pairs(lootTable) do
		for Boss, LootList in pairs(BossList) do
			for _, itemID in pairs(LootList) do
				count = count + 1
				filters:SetSearchedItem(itemID)
				
				if filters:ItemPassesFilters() then
					OnMatch(Instance, Boss)
				else
					if OnNoMatch then
						OnNoMatch()
					end
				end
			end
		end
	end
	
	filters:ClearSearchedItem()
	return count
end

local function ParseLPTSet(set, OnMatch, OnNoMatch)
	assert(type(OnMatch) == "function")
	
	local PT = LibStub("LibPeriodicTable-3.1")
	if not PT then return 0 end		-- exit if LPT is not active

	-- LPT stores certain sets twice, but does not offer the possibility to differentiate entries (instances that are part of hubs)
	-- So keep track of the sets we've already parsed, to avoid returning items twice.
	local doneSets = {}
	local count = 0

	for _, list in pairs(PT:GetSetTable(set)) do
		local _, domain, subdomain = strsplit(".", list.set)
		
		if not doneSets[list.set] then			-- if this set hasn't been parsed yet, proceed..
			for itemID, value in pairs(list) do
				if tostring(itemID) ~= "set" then
					count = count + 1
					filters:SetSearchedItem(itemID)
					
					if filters:ItemPassesFilters() then
						OnMatch(domain, subdomain or value)		-- pass the value in case "subdomain" is nil
					else
						if OnNoMatch then
							OnNoMatch()
						end
					end
				end
			end
		end
		doneSets[list.set] = true
	end
	
	filters:ClearSearchedItem()
	return count
end

local allowedQueries, unknownCount

local function OnMatch(domain, subdomain)
	Altoholic.Search:AddResult( {
		id = filters:GetSearchedItemInfo("itemID"),
		iLvl = filters:GetSearchedItemInfo("itemLevel"),
		dropLocation = domain,
		bossName = subdomain,
	} )
end

local function Currency_OnMatch(domain, subdomain)
	Altoholic.Search:AddResult( {
		id = filters:GetSearchedItemInfo("itemID"),
		iLvl = filters:GetSearchedItemInfo("itemLevel"),
		dropLocation = domain,
		bossName = subdomain.."x",
	} )
end

local function OnNoMatch()
--	if FilterByExistence() then return end 	-- if the item exists, do nothing
	if filters:TryFilter("Existence") then return end 	-- if the item exists, do nothing
	unknownCount = unknownCount + 1
	
	if allowedQueries > 0 then
		if Altoholic.Options:Get("SearchAutoQuery") == 1 then		-- if autoquery is enabled
			local itemID = filters:GetSearchedItemInfo("itemID")
			if not addon:IsItemUnsafe(itemID) then		-- if the item is not known to be unsafe
				GameTooltip:SetHyperlink("item:"..itemID..":0:0:0:0:0:0:0")	-- this line queries the server for an unknown id
				GameTooltip:ClearLines(); -- don't leave residual info in the tooltip after the server query

				-- save ALL tested id's, clean the list in OnEnable during the next session.
				-- the unsafe list will be cleaned in OnEnable, by parsing all ids and testing if getiteminfo returns a nil or not, if so, it's a definite unsafe link
				addon:SaveUnsafeItem(itemID)			-- save id to unsafe list
			end
		end
		allowedQueries = allowedQueries - 1
	end
end

function ns:Find()
	unknownCount = 0
	allowedQueries = 5
	local count = ParseAltoholicLoots(OnMatch, OnNoMatch)
	count = count + ParseLPTSet("InstanceLoot", OnMatch, OnNoMatch)
	count = count + ParseLPTSet("InstanceLootHeroic", OnMatch, OnNoMatch)
	count = count + ParseLPTSet("CurrencyItems", Currency_OnMatch, OnNoMatch)

	addon.Options:Set("TotalLoots", count)
	addon.Options:Set("UnknownLoots", unknownCount)
end

function ns:FindUpgrade()
	local function OnMatch(domain, subdomain)
		addon.Search:AddResult( {
			id = filters:GetSearchedItemInfo("itemID"),
			iLvl = filters:GetSearchedItemInfo("itemLevel"),
			dropLocation = domain,
			bossName = subdomain,
		} )
	end
	
	ParseAltoholicLoots(OnMatch)
	ParseLPTSet("InstanceLoot", OnMatch)
	ParseLPTSet("InstanceLootHeroic", OnMatch)
	ParseLPTSet("CurrencyItems", Currency_OnMatch)
end

local tooltipLines			-- cache containing the text lines of the tooltip "+15 stamina, etc.."
local rawItemStats			-- contains the raw stats of the item currently being searched, placed here to avoid creating/deleting the table during the search
local currentItemStats		-- contains the stats of the item for which we'll try to find upgrades

local classExcludedStats
local classBaseStats

local function AddCurrentlyEquippedItem(itemID, class)

	AltoTooltip:SetOwner(AltoholicFrame, "ANCHOR_LEFT")
	local _, itemLink, _, itemLevel = GetItemInfo(itemID)
	AltoTooltip:SetHyperlink(itemLink)
	
	local statLine = addon.Equipment.FormatStats[class]
	local numLines = AltoTooltip:NumLines()
	
	local j=1
	for _, BaseStat in pairs(classBaseStats) do
		for i = 4, numLines do
			local tooltipText = _G[ "AltoTooltipTextLeft" .. i]:GetText()
			if tooltipText then
				if string.find(tooltipText, BaseStat) ~= nil then
					currentItemStats[BaseStat] = tonumber(string.sub(tooltipText, string.find(tooltipText, "%d+")))
					statLine = string.gsub(statLine, "-s", WHITE .. currentItemStats[BaseStat], 1)
					
					rawItemStats[j] = currentItemStats[BaseStat] .. "|0"
					break
				end
			end
		end
		if not currentItemStats[BaseStat] then
			rawItemStats[j] = "0|0"
		
			currentItemStats[BaseStat] = 0 -- Set the current stat to zero if it was not found on the item
			statLine = string.gsub(statLine, "-s", WHITE .. "0", 1)
		end
		j = j + 1
	end
	AltoTooltip:ClearLines();
	
	-- Save currently equipped item to the results table
	addon.Search:AddResult( {
		id = itemID,
		iLvl = itemLevel,
		dropLocation = "Currently equipped",
		stat1 = rawItemStats[1],
		stat2 = rawItemStats[2],
		stat3 = rawItemStats[3],
		stat4 = rawItemStats[4],
		stat5 = rawItemStats[5],
		stat6 = rawItemStats[6]
	} )
end

local function MatchUpgradeByStats(itemID)
	filters:SetSearchedItem(itemID)
	if not filters:ItemPassesFilters() then 
		filters:ClearSearchedItem()
		return
	end

	AltoTooltip:ClearLines();	
	AltoTooltip:SetOwner(AltoholicFrame, "ANCHOR_LEFT");
	AltoTooltip:SetHyperlink(filters:GetSearchedItemInfo("itemLink"))
	
	-- save some time by trying to find out if the item could be excluded
	wipe(tooltipLines)
	for i = 4, AltoTooltip:NumLines() do	-- parse all tooltip lines, one by one, start at 4 since 1= item name, 2 = binds on.., 3 = type/slot/unique ..etc
		-- in this first pass, save the lines into a cache, reused below
		local tooltipLine = _G[ "AltoTooltipTextLeft" .. i]:GetText()
		if tooltipLine then
			if string.find(tooltipLine, L["Socket"]) == nil then
				for _, v in pairs(classExcludedStats) do
					--if string.find(tooltipLine, v, 1, true) ~= nil then return end
					if string.find(tooltipLine, v) ~= nil then return end
				end
				tooltipLines[i] = tooltipLine
			end
		end
	end
	
	local statFound
	local j=1
	for _, BaseStat in pairs(classBaseStats) do

		statFound = nil
		for i, tooltipText in pairs(tooltipLines) do
			--if string.find(tooltipText, BaseStat, 1, true) ~= nil then
			if string.find(tooltipText, BaseStat) ~= nil then
				--local stat = tonumber(string.sub(tooltipText, string.find(tooltipText, "%d+")))
				local stat = tonumber(string.match(tooltipText, "%d+"))
				
				rawItemStats[j] = stat .. "|" .. (stat - currentItemStats[BaseStat])
				table.remove(tooltipLines, i)	-- remove the current entry, so it won't be parsed in the next loop cycle
				statFound = true
				break
			end
		end
		
		if not statFound then
			rawItemStats[j] = "0|" .. (0 - currentItemStats[BaseStat])
		end
		j = j + 1
	end
	
	local iLvl = filters:GetSearchedItemInfo("itemLevel")
	filters:ClearSearchedItem()
		
	-- All conditions ok ? save it
	return true, iLvl
end

-- modify this one after 3.2, to use GetItemStats
function ns:FindUpgradeByStats(currentID, class)
	classExcludedStats = addon.Equipment.ExcludeStats[class]
	classBaseStats = addon.Equipment.BaseStats[class]
	
	rawItemStats = {}
	currentItemStats = {}
	tooltipLines = {}
	
	AddCurrentlyEquippedItem(currentID, class)
	
	for Instance, BossList in pairs(lootTable) do		-- parse the loot table to find an upgrade
		for Boss, LootList in pairs(BossList) do
			for _, itemID in pairs(LootList) do
			
				local matches, itemLevel = MatchUpgradeByStats(itemID)
				
				if matches then
					addon.Search:AddResult( {
						id = itemID,
						iLvl = itemLevel,
						dropLocation = Instance .. ", " .. GREEN .. Boss,
						stat1 = rawItemStats[1],
						stat2 = rawItemStats[2],
						stat3 = rawItemStats[3],
						stat4 = rawItemStats[4],
						stat5 = rawItemStats[5],
						stat6 = rawItemStats[6]
					} )
				end
			end
		end
	end
	
	classExcludedStats = nil
	classBaseStats = nil
	currentItemStats = nil
	tooltipLines = nil
	rawItemStats = nil
end
