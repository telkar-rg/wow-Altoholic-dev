local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local print = function(...) DEFAULT_CHAT_FRAME:AddMessage("\124cff00ccff{".. tostring(addonName) .. "-Keys}:\124r " .. strjoin("; ", tostringall(...))) end

local isViewValid
local collapsedHeaders

local ICON_DISABLED = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_ENABLED  = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"
local ICON_UNKNOWN  = "\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t"
local ICON_LIST = {ICON_DISABLED, ICON_ENABLED, ICON_UNKNOWN}
-- local ICON_ALLIANCE = "|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:16:16:0:0:64:64:0:36:0:36|t"
-- local ICON_HORDE    = "|TInterface\\TargetingFrame\\UI-PVP-HORDE:16:16:0:0:64:64:0:36:0:36|t"
local ICON_ALLIANCE = "|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:16:16:0:0:40:40:2:26:0:24|t"
local ICON_HORDE    = "|TInterface\\TargetingFrame\\UI-PVP-HORDE:16:16:0:0:40:40:2:26:0:24|t"
-- local ICON_ALLIANCE = "|TInterface\\Icons\\achievement_pvp_a_a:16|t"
-- local ICON_HORDE    = "|TInterface\\Icons\\achievement_pvp_h_h:16|t"
local ICON_LIST_FACTION = {ICON_ALLIANCE, ICON_HORDE}

-- colors
local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local DARKYELLOW = "|cffffd100"

local VertexColors = {
	["GRAY"]   = { r = 0.3, g = 0.3, b = 0.3 },
	["ORANGE"] = { r = 0.6, g = 0.4, b = 0.13 },
	["WHITE"]  = { r = 1.0, g = 1.0, b = 1.0 },
	{ r = 0.4, g = 0.13, b = 0.13 },	-- hated
	{ r = 0.5, g = 0.0, b = 0.0 },		-- hostile
	{ r = 0.6, g = 0.4, b = 0.13 },		-- unfriendly
	{ r = 0.6, g = 0.6, b = 0.0 },		-- neutral
	{ r = 0.0, g = 0.6, b = 0.0 },		-- friendly
	{ r = 0.0, g = 0.6, b = 0.4 },		-- honored
	{ r = 0.0, g = 0.6, b = 0.6 },		-- revered
	{ r = 1.0, g = 1.0, b = 1.0 },		-- exalted
}

local currentFactionGroup = (UnitFactionGroup("player") == "Alliance") and 1 or 2	-- default to alliance or horde



-- local function FormatQuestType(tag, size)
	-- if questSizeColors[size] then
		-- return format("%s%s%s (%d)", WHITE, tag, questSizeColors[size], size)
	-- else
		-- return format("%s%s", WHITE, tag)
	-- end
-- end

addon.Keys = {}

local QuestNames = {
	[838] = L["QuestTitle-838"],
	[964] = L["QuestTitle-964"],
	[5092] = L["QuestTitle-5092"],
	[5096] = L["QuestTitle-5096"],
	[5097] = L["QuestTitle-5097"],
	[5098] = L["QuestTitle-5098"],
	[5505] = L["QuestTitle-5505"],
	[5511] = L["QuestTitle-5511"],
	[5514] = L["QuestTitle-5514"],
	[5533] = L["QuestTitle-5533"],
	[5537] = L["QuestTitle-5537"],
	[5538] = L["QuestTitle-5538"],
	[5801] = L["QuestTitle-5801"],
	[5802] = L["QuestTitle-5802"],
	[5803] = L["QuestTitle-5803"],
	[5804] = L["QuestTitle-5804"],
	[7487] = L["QuestTitle-7487"],
	[7761] = L["QuestTitle-7761"],
	[7848] = L["QuestTitle-7848"],

	[9824] = L["QuestTitle-9824"],
	[9825] = L["QuestTitle-9825"],
	[9826] = L["QuestTitle-9826"],
	[9829] = L["QuestTitle-9829"],
	[9831] = L["QuestTitle-9831"],
	[9832] = L["QuestTitle-9832"],
	[9836] = L["QuestTitle-9836"],
	[9837] = L["QuestTitle-9837"],

	[10754] = L["QuestTitle-10754"],
	[10755] = L["QuestTitle-10755"],
	[10756] = L["QuestTitle-10756"],
	[10757] = L["QuestTitle-10757"],
	[10758] = L["QuestTitle-10758"],
	[10762] = L["QuestTitle-10762"],
	[10763] = L["QuestTitle-10763"],
	[10764] = L["QuestTitle-10764"],

	[10263] = L["QuestTitle-10263"],
	[10264] = L["QuestTitle-10264"],
	[10265] = L["QuestTitle-10265"],
	[10262] = L["QuestTitle-10262"],
	[10205] = L["QuestTitle-10205"],
	[10266] = L["QuestTitle-10266"],
	[10267] = L["QuestTitle-10267"],
	[10268] = L["QuestTitle-10268"],
	[10269] = L["QuestTitle-10269"],
	[10275] = L["QuestTitle-10275"],
	[10276] = L["QuestTitle-10276"],
	[10280] = L["QuestTitle-10280"],
	[10704] = L["QuestTitle-10704"],

	[10279] = L["QuestTitle-10279"],
	[10277] = L["QuestTitle-10277"],
	[10282] = L["QuestTitle-10282"],
	[10283] = L["QuestTitle-10283"],
	[10284] = L["QuestTitle-10284"],
	[10285] = L["QuestTitle-10285"],

	[11488] = L["QuestTitle-11488"],
	[11490] = L["QuestTitle-11490"],
	[11492] = L["QuestTitle-11492"],

	[13604] = L["QuestTitle-13604"],
	[13607] = L["QuestTitle-13607"],
	[13606] = L["QuestTitle-13606"],
	[13609] = L["QuestTitle-13609"],
	[13610] = L["QuestTitle-13610"],
	[13611] = L["QuestTitle-13611"],
	[13614] = L["QuestTitle-13614"],

	[13817] = L["QuestTitle-13817"],
	[13816] = L["QuestTitle-13816"],
	[13821] = L["QuestTitle-13821"],
	[13822] = L["QuestTitle-13822"],
	[13823] = L["QuestTitle-13823"],
	[13824] = L["QuestTitle-13824"],
	[13818] = L["QuestTitle-13818"]
}

local ItemNames = {
	[6893] = "Workshop Key",
	[7146] = "The Scarlet Key",
	[11000] = "Shadowforge Key",
	[12382] = "Key to the City",
	[13704] = "Skeleton Key",
	[18249] = "Crescent Key",
	
	[24490] = "The Master's Key",
	[27991] = "Shadow Labyrinth Key",
	[30622] = "Flamewrought Key",
	[30623] = "Reservoir Key",
	[30633] = "Auchenai Key",
	[30634] = "Warpforged Key",
	[30635] = "Key of Time",
	[30637] = "Flamewrought Key",
	[31084] = "Key to the Arcatraz",
	
	[44581] = "Heroic Key to the Focusing Iris",
	[44582] = "Key to the Focusing Iris",
	[45796] = "Celestial Planetarium Key",
	[45798] = "Heroic Celestial Planetarium Key",
}

local KeyList = {
	-- https://wowpedia.fandom.com/wiki/Instance_attunement_(Classic)
	{	-- ####################
		name = "Classic",
		isHeader = true,
	},
	
	{ 
		name = BZ["Scarlet Monastery"], 
		notes = L["KEY_NOTE_ScarletMonastery"], 
		aquisition = {type="item", item=7146 },
		icon = "inv_misc_key_01",
		lockpick = 175
	}, 	-- The Scarlet Key
	{ 
		name = BZ["Gnomeregan"], 
		notes = L["KEY_NOTE_Gnomeregan"], 
		aquisition = {type="item", item=6893 },
		icon = "inv_misc_key_06",
		lockpick = 150
	}, 	-- Workshop Key
	-- { 
		-- name = BZ["Sunken Temple"], 
		-- notes = L["KEY_NOTE_SunkenTemple"], 
		-- aquisition = {type="questitem", quest={3520, 3527, 4787, 3528}, item=10818 },
		-- icon = "inv_scroll_02"
	-- }, 	-- Yeh'kinya's Scroll
	{ 
		name = BZ["Blackrock Depths"],
		notes = L["KEY_NOTE_BlackrockDepths"], 
		aquisition = {type="item", item=11000 },
		icon = "inv_misc_key_08",
		lockpick = 250
	}, 	-- Shadowforge Key
	{ 
		name = BZ["Dire Maul"],
		notes = L["KEY_NOTE_DireMaul"], 
		aquisition = {type="item", item=18249 },
		icon = "inv_misc_key_10",
		lockpick = 300
	}, 	-- Crescent Key
	{ 
		name = BZ["Scholomance"],
		faction=true,
		notes = {L["KEY_NOTE_Scholomance_A"], L["KEY_NOTE_Scholomance_H"]},
		-- notesA = L["KEY_NOTE_Scholomance_A"], 
		-- notesH = L["KEY_NOTE_Scholomance_H"], 
		aquisition = {
			type="questitem", 
			faction=true, 
			quest={ {5092, 5097, 5533, 5537, 5538, 5801, 5803, 5505}, {5096, 5098, 838, 964, 5514, 5802, 5804, 5511} },
			-- questA={5092, 5097, 5533, 5537, 5538, 5801, 5803, 5505}, 
			-- questH={5096, 5098,  838,  964, 5514, 5802, 5804, 5511}, 
			item={13704,13704}
			-- itemA=13704,
			-- itemH=13704
		},
		icon = "inv_misc_key_11",
		lockpick = 280
	}, 	-- Skeleton Key
	{ 
		name = BZ["Stratholme"],
		notes = L["KEY_NOTE_Stratholme"], 
		aquisition = {type="item", item=12382 },
		icon = "inv_misc_key_13",
		lockpick = 300
	}, 	-- Key to the City
	-- { name = BZ["Upper Blackrock Spire"], icon = "achievement_boss_generaldrakkisath" }, 	-- Seal of Ascension
	{ 
		name = BZ["Molten Core"],
		notes = L["KEY_NOTE_MoltenCore"], 
		aquisition = { 
			type="quest", 
			faction=true, 
			quest={ {7848},{7487} }
		},
		icon = "inv_misc_gem_opal_01"
	}, 	-- Attunement to the Core
	{ 
		name = BZ["Blackwing Lair"],
		notes = L["KEY_NOTE_BlackwingLair"], 
		aquisition = { type="quest", quest={7761} },
		icon = "inv_letter_17"
	}, 	-- Drakkisath's Brand
	
	-- https://wowpedia.fandom.com/wiki/Instance_attunement_(Burning_Crusade)
	{	-- ####################
		name = "The Burning Crusade",
		isHeader = true,
	},
	
	{
		name = BZ["Old Hillsbrad Foothills"],
		notes = L["KEY_NOTE_OldHillsbradFoothills"], 
		aquisition = { type="quest", quest={10279,10277} },
		icon = "achievement_zone_hillsbradfoothills"
	}, 	-- quest=10277 Die Höhlen der Zeit
	{
		name = BZ["The Black Morass"], 
		notes = L["KEY_NOTE_TheBlackMorass"], 
		aquisition = { type="quest", quest={10282,10283,10284,10285} },
		icon = "achievement_zone_dustwallowmarsh"
	}, 	-- quest=10285 Rückkehr zu Andormu
	{
		name = BZ["Shadow Labyrinth"],
		notes = L["KEY_NOTE_ShadowLabyrinth"], 
		aquisition = { type="item", item=27991 },
		icon = "inv_misc_key_02",
		lockpick = 350
	}, 	-- Shadow Labyrinth Key
	{
		name = BZ["The Arcatraz"],
		notes = L["KEY_NOTE_TheArcatraz"], 
		aquisition = {
			type="questitem",
			quest={10263,10264,10265,10262,10205,10266,10267,10268,10269,10275,10276,10280,10704},
			item=31084
		},
		icon = "inv_datacrystal03",
		lockpick = 350
	}, 	-- Key to the Arcatraz
	{ 
		name = BZ["Karazhan"],
		notes = L["KEY_NOTE_Karazhan"], 
		aquisition = {
			type="questitem",
			quest={9824,9825,9826,9829,9831,9832,9836,9837},
			item=24490
		},
		icon = "inv_misc_key_07",
		lockpick = 350
	}, 	-- The Master's Key
	{
		name = BZ["The Shattered Halls"],
		notes = L["KEY_NOTE_TheShatteredHalls"],
		aquisition = {
			type="questitem", 
			faction=true, 
			quest={ {10754, 10762, 10763, 10764}, {10755, 10756, 10757, 10758} },
			-- questA={10754, 10762, 10763, 10764}, 
			-- questH={10755, 10756, 10757, 10758}, 
			item={28395,28395}
			-- itemA=28395,
			-- itemH=28395
		},
		icon = "inv_misc_key_02",
		lockpick = 350
	}, 	-- Shattered Halls Key
	-- {
		-- name = BZ["Black Temple"],
		-- notes = L["KEY_NOTE_BlackTemple"], 
		-- aquisition = {
			-- type="questitem",
			-- quest = {
				-- 10568, 	-- Schrifttafeln von Baa'ri (Aldor)
				-- 10683, 	-- Schrifttafeln von Baa'ri (Seher)
				-- 10571, 	-- Oronu der Älteste (Aldor)
				-- 10684, 	-- Oronu der Älteste (Seher)
				-- 10574, 	-- Die Verderber der Aschenzungen (Aldor)
				-- 10685, 	-- Die Verderber der Aschenzungen (Seher)
				-- 10575, 	-- Der Kerker des Wächters (Aldor)
				-- 10686, 	-- Der Kerker des Wächters (Seher)
				-- 10622, 	-- Ein Beweis der Treue
				-- 10628, 	-- Akama
				-- 10705, 	-- Seher Udalo
				-- 10706, 	-- Ein mysteriöses Omen
				-- 10707, 	-- Die Terrasse von Ata'mal
				-- 10708, 	-- Akamas Versprechen
				-- 10944, 	-- Das gefährdete Geheimnis
				-- 10946, 	-- Die List der Aschenzungen
			-- },
			-- item=31084
		-- },
		-- icon = "inv_datacrystal03",
		-- lockpick = 350
	-- }, 	-- 	Medaillon von Karabor
	
	
	{ 
		name = L["Heroic"]..": "..BZ["Hellfire Citadel"],
		faction=true,
		notes = {L["KEY_NOTE_HellfireCitadel_A"], L["KEY_NOTE_HellfireCitadel_H"]},
		-- notes = L["KEY_NOTE_HellfireCitadel"], 
		aquisition = { 
			type="repitem", 
			faction=true, 
			item={30622,30637},
			rep={ {9000,BF["Honor Hold"]},{9000,BF["Thrallmar"]} }
		},
		icon = "inv_misc_key_13"
	}, 	-- Flamewrought Key
	{ 
		name = L["Heroic"]..": "..BZ["Coilfang Reservoir"],
		notes = L["KEY_NOTE_CoilfangReservoir"], 
		aquisition = { 
			type="repitem", 
			item=30623,
			rep={9000,BF["Cenarion Expedition"]}
		},
		icon = "inv_misc_key_13"
	}, 	-- Reservoir Key
	{
		name = L["Heroic"]..": "..BZ["Auchindoun"],
		notes = L["KEY_NOTE_Auchindoun"], 
		aquisition = {
			type="repitem", 
			item=30633,
			rep={9000,BF["Lower City"]}
		},
		icon = "inv_misc_key_11"
	}, 	-- Auchenai Key
	{
		name = L["Heroic"]..": "..BZ["Tempest Keep"],
		notes = L["KEY_NOTE_TempestKeep"], 
		aquisition = {
			type="repitem", 
			item=30634,
			rep={9000,BF["The Sha'tar"]}
		},
		icon = "inv_misc_key_09"
	}, 	-- Warpforged Key
	{
		name = L["Heroic"]..": "..BZ["Caverns of Time"],
		notes = L["KEY_NOTE_CavernsofTime"], 
		aquisition = {
			type="repitem", 
			item=30635,
			rep={9000,BF["Keepers of Time"]}
		},
		icon = "inv_misc_key_04"
	}, 	-- Key of Time
	
	{
		name = L["Heroic"]..": "..BZ["Magisters' Terrace"],
		notes = L["KEY_NOTE_MagistersTerrace"], 
		aquisition = { type="quest", quest={11488,11490,11492} },
		icon = "ability_warrior_innerrage"
	}, 	-- quest=11492 Nicht totzukriegen
	
	{	-- ####################
		name = "Wrath of the Lich King",
		isHeader = true,
	},
	
	{
		name = BB["Malygos"].." (10)",
		notes = L["KEY_NOTE_Malygos_10"], 
		aquisition = {type="item", item=44582 },
		icon = "spell_holy_mindsooth"
	}, 	-- item=44582 Malygos 10
	{ 
		name = BB["Malygos"].." (25)",
		notes = L["KEY_NOTE_Malygos_25"], 
		aquisition = {type="item", item=44581 },
		icon = "spell_holy_mindsooth"
	}, 	-- item=44581 Malygos 25
	
	{
		name = BB["Algalon the Observer"].." (10)",
		notes = L["KEY_NOTE_AlgalontheObserver_10"], 
		aquisition = { 
			type="questitem", 
			quest={13604,13607,13606,13609,13610,13611,13614},
			item=45796
		},
		icon = "inv_misc_key_15"
	}, 	-- item=45796 Algalon 10
	{
		name = BB["Algalon the Observer"].." (25)",
		notes = L["KEY_NOTE_AlgalontheObserver_25"], 
		aquisition = { 
			type="questitem", 
			quest={13817,13816,13821,13822,13823,13824,13818},
			item=45798
		},
		icon = "inv_misc_key_15"
	}, 	-- item=45798 Algalon 25
}

local setStringColorPrefix = function(txt, color)
	return tostring(color) .. txt .. "|r"
end

local ns = addon.Keys		-- ns = namespace

function ns:Update()
	-- print("Update")
	-- local character = addon.Tabs.Characters:GetCurrent()

	AltoTooltip:Hide();
	GameTooltip:Hide();
	
	local VisibleLines = 8
	local NumLines = VisibleLines
	local frame = "AltoholicFrameKeys"
	local entry = frame.."Entry"
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character
	
	-- if DS:GetQuestLogSize(character) == 0 then
		-- AltoholicTabCharactersStatus:SetText(L["No quest found for "] .. addon:GetCurrentCharacter())
		-- addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		-- return
	-- end
	AltoholicTabCharactersStatus:SetText("")
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup

	collapsedHeaders = collapsedHeaders or {}
	if not isViewValid then
		wipe(collapsedHeaders)
		isViewValid = true
	end

	local i=1
	-- print("offset",offset)
	
	-- for line = 1, DS:GetQuestLogSize(character) do
	for line, keyEntry in pairs(KeyList) do
		-- local isHeader, quest, questTag, groupSize, money, isComplete = DS:GetQuestLogInfo(character, line)
		local isHeader = not(keyEntry.aquisition)
		local name = keyEntry.name or "<?>"
		-- local name = tostring(line).." ".. (keyEntry.name or "<?>") 	-- DEBUG
		local icon = keyEntry.icon or "inv_misc_questionmark"
		local aquisition = keyEntry.aquisition
		-- print("--",
		-- "line",line,
		-- "name",name,
		-- "offset",offset,
		-- "VisibleCount",VisibleCount,
		-- "isHeader",isHeader)
		
		-- _G[ entry..i ].isHeader = nil
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if isHeader then													-- then keep track of counters
				
				if not collapsedHeaders[line] then
					DrawGroup = true
				else
					DrawGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			_G[ entry..i ].isHeader = nil
			if isHeader then
				_G[ entry..i ].isHeader = true
				
				if not collapsedHeaders[line] then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				
				-- _G[entry..i.."Name"]:SetText( setStringColorPrefix(name, DARKYELLOW) )
				_G[entry..i.."EntryLinkText"]:SetText( setStringColorPrefix(name, TEAL) )
				-- _G[entry..i.."EntryLink"]:SetJustifyH("LEFT")
				-- _G[entry..i.."EntryLink"]:SetPoint("TOPLEFT", 25, 0)
				
				-- print(entry..i.."EntryLink")
				_G[entry..i.."EntryLink"]:SetID(0)
				_G[entry..i.."EntryLink"]:SetPoint("TOPLEFT", 25, 0)
				
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				
				for j = 1, 10 do	-- loop through the 10 alts
					local itemName = entry.. i .. "Item" .. j;
					local itemButton = _G[itemName]
					itemButton:Hide()
				end
				
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()
				_G[ entry..i ].keyEntry = keyEntry 	-- store info for Key in line frame
				
				-- local _, _, level = DS:GetQuestInfo(quest)
				-- quick fix, level may be nil, I suspect that due to certain locales, the quest link may require different parsing.
				-- level = level or 0
				local linkName = name
				if not keyEntry.notes then 
					linkName = setStringColorPrefix(name, WHITE)
				end
				
				_G[entry..i.."EntryLinkText"]:SetText( linkName )
				-- _G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."EntryLink"]:SetID(line)
				_G[entry..i.."EntryLink"]:SetPoint("TOPLEFT", 10, 0)
				
				
				for j = 1, 10 do	-- loop through the 10 alts
					local itemName = entry.. i .. "Item" .. j;
					local itemButton = _G[itemName]
					local classButton = _G["AltoholicFrameClassesItem" .. j]
					
					local itemTexture = _G[itemName .. "_Background"]
					itemTexture:SetTexture("Interface\\Icons\\"..icon)

					local status, charFaction, itemBags, itemBank, searchedID, questList, repList, progress
					
					if classButton.CharName then	-- if there's an alt in this column..
						itemButton.CharName = classButton.CharName
						-- itemButton.keyEntry = keyEntry
						
						-- if character then wipe(character) end
						if questList then wipe(questList) end
						character = DS:GetCharacter(classButton.CharName, realm, account)
						charFaction = (DS:GetCharacterFaction(character) == "Alliance") and 1 or 2
						-- questHistory = DS:GetQuestHistory(character) or {}
						progress = 0
						status = false
						
						if aquisition.type == "item" then
							if aquisition.faction then
								searchedID = aquisition.item[charFaction]
							else
								searchedID = aquisition.item
							end
							itemBags, itemBank = DataStore:GetContainerItemCount(character, searchedID)
							status = (itemBags + itemBank) > 0
						elseif aquisition.type == "quest" then
							if aquisition.faction then
								questList = aquisition.quest[charFaction]
							else
								questList = aquisition.quest
							end
							if DS:IsQuestCompletedBy(character, questList[#questList]) then 	-- if the last quest is done, then we are active
								status = true
							else 	-- else: we calculate the quest progress 
								progress = 0
								for _,questID in pairs(questList) do
									if DS:IsQuestCompletedBy(character, questID) then progress=progress+1 end
								end
								progress = progress / #questList
							end
							
						elseif aquisition.type == "questitem" then
							if aquisition.faction then
								searchedID = aquisition.item[charFaction]
								questList = aquisition.quest[charFaction]
							else
								searchedID = aquisition.item
								questList = aquisition.quest
							end
							itemBags, itemBank = DataStore:GetContainerItemCount(character, searchedID)
							status = (itemBags + itemBank) > 0
							
							if not(status) then
								if DS:IsQuestCompletedBy(character, questList[#questList]) then 	-- if the last quest is done, then we are active
									status = true
								else 	-- else: we calculate the quest progress 
									progress = 0
									for _,questID in pairs(questList) do
										if DS:IsQuestCompletedBy(character, questID) then progress=progress+1 end
									end
									progress = progress / #questList
								end
							end
						elseif aquisition.type == "repitem" then
							if aquisition.faction then
								searchedID = aquisition.item[charFaction]
								repList = aquisition.rep[charFaction]
							else
								searchedID = aquisition.item
								repList = aquisition.rep
							end
							itemBags, itemBank = DataStore:GetContainerItemCount(character, searchedID)
							status = (itemBags + itemBank) > 0
							
							if not(status) then
								local _,_,repEarned = DS:GetRawReputationInfo(character, repList[2])
								-- print(repEarned, type(repEarned))
								if not repEarned then
									progress=0
								else
									progress = repEarned/repList[1]
									progress = math.min(1,progress)
									progress = math.max(0,progress)
								end
							end
						end
						
						itemButton.status = status
						
						local vc, text
						if status then 
							vc = VertexColors["WHITE"]
							itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
							
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 10, 0)
							
							_G[itemName .. "Name"]:SetText( ICON_ENABLED )
						elseif progress > 0 then
							local cr,cg,cb = 0.6, 0.2+0.6*progress, 0
							if progress >= 0.999 then cr,cg,cb = 0, 0.6, 0.6 end
							
							itemTexture:SetVertexColor(cr,cg,cb);
							
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 0, 0)
							
							text = format("%2d", floor(progress*100+0.5)) .. "%"
							_G[itemName .. "Name"]:SetText( text )
							
						else
							vc = VertexColors["GRAY"]
							itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
							
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 10, 0)
							
							_G[itemName .. "Name"]:SetText( ICON_DISABLED )
							-- itemButton.CharName = nil
						end
						itemButton:Show()				
					else
						itemButton:Hide()
					end
				end
					
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end 

	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end
	
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 41);
end

function ns:InvalidateView()
	-- print("InvalidateView")
	isViewValid = nil
end


function ns:Collapse_OnClick(frame, button)
	-- print("Collapse_OnClick(frame, button)")
	-- if true then return end
	
	local id = frame:GetParent():GetID()
	if id ~= 0 then
		collapsedHeaders[id] = not collapsedHeaders[id]
		ns:Update()
	end
end

function ns:Item_OnEnter(frame)
	-- print("-- Item_OnEnter(frame)")
	local charName = frame.CharName
	if not charName then return end
	local parentframe = frame:GetParent()
	local keyEntry = parentframe.keyEntry
	if not keyEntry then return end
	local status = frame.status
	local aquisition = keyEntry.aquisition
	local nameKey = keyEntry.name or "<?>"
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	
	local charFaction = (DS:GetCharacterFaction(character) == "Alliance") and 1 or 2
	local itemID, questList, repList
	
	if aquisition.type == "item" then
		if aquisition.faction then
			itemID = aquisition.item[charFaction]
		else
			itemID = aquisition.item
		end
		if not itemID then return end

		GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
		local link
		if type(itemID) == "number" then
			link = select(2, GetItemInfo(itemID))
		end
		
		if not link then
			-- GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1);
			-- GameTooltip:Show();
			return
		end
		
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
		return
	
	elseif aquisition.type == "quest" then
		if aquisition.faction then
			questList = aquisition.quest[charFaction]
		else
			questList = aquisition.quest
		end
		
		AltoTooltip:SetOwner(frame, "ANCHOR_LEFT")
		AltoTooltip:ClearLines()
		AltoTooltip:AddLine( format("%s|r: %s", DS:GetColoredCharacterName(character), nameKey) )
		AltoTooltip:AddLine(" ")
		
		local questDone, cr,cg,cb
		for _,questID in pairs(questList) do
			questDone = 1
			cr,cg,cb = 1,0.15,0.15
			if DS:IsQuestCompletedBy(character, questID) then
				questDone = 2
				cr,cg,cb = 0.1,1,0.1
			else
				local isActiveQuest = nil
				local questLogSize = DS:GetQuestLogSize(character) or 0
				for i = 1, questLogSize do
					local isHeader, link = DS:GetQuestLogInfo(character, i)
					if not isHeader then
						local altQuestName, altQuestID = DS:GetQuestInfo(link)
						if altQuestID == questID then		-- same quest found
							isActiveQuest = true
							break
						end
					end
				end
				
				if isActiveQuest then
					questDone = 3
					cr,cg,cb = 1,0.8,0
				end
			end
			AltoTooltip:AddLine( format("%s %s", ICON_LIST[questDone], tostring(QuestNames[questID]) ), cr,cg,cb )
		end
		
		AltoTooltip:Show()
		return
		
	elseif aquisition.type == "questitem" then
		if aquisition.faction then
			itemID = aquisition.item[charFaction]
			questList = aquisition.quest[charFaction]
		else
			itemID = aquisition.item
			questList = aquisition.quest
		end
		-- status
		if status then
			GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
			local link
			if type(itemID) == "number" then
				link = select(2, GetItemInfo(itemID))
			end
			if not link then return end
			
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()
			return
			
		else
			AltoTooltip:SetOwner(frame, "ANCHOR_LEFT")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine( format("%s|r: %s", DS:GetColoredCharacterName(character), nameKey) )
			AltoTooltip:AddLine(" ")
			
			local questDone, cr,cg,cb
			for _,questID in pairs(questList) do
				questDone = 1
				cr,cg,cb = 1,0.15,0.15
				if DS:IsQuestCompletedBy(character, questID) then
					questDone = 2
					cr,cg,cb = 0.1,1,0.1
				else
					local isActiveQuest = nil
					local questLogSize = DS:GetQuestLogSize(character) or 0
					for i = 1, questLogSize do
						local isHeader, link = DS:GetQuestLogInfo(character, i)
						if not isHeader then
							local altQuestName, altQuestID = DS:GetQuestInfo(link)
							if altQuestID == questID then		-- same quest found
								isActiveQuest = true
								break
							end
						end
					end
					
					if isActiveQuest then
						questDone = 3
						cr,cg,cb = 1,0.8,0
					end
				end
				AltoTooltip:AddLine( format("%s %s", ICON_LIST[questDone], tostring(QuestNames[questID]) ), cr,cg,cb )
			end
			
			AltoTooltip:Show()
			return
		end
		
		
	-- elseif true then
		-- return
		
	elseif aquisition.type == "repitem" then
		if aquisition.faction then
			itemID = aquisition.item[charFaction]
			repList = aquisition.rep[charFaction]
		else
			itemID = aquisition.item
			repList = aquisition.rep
		end
		
		if status then
			GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
			local link
			if type(itemID) == "number" then
				link = select(2, GetItemInfo(itemID))
			end
			if not link then return end
			
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()
			return
			
		else
			AltoTooltip:SetOwner(frame, "ANCHOR_LEFT")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine( format("%s|r: %s", DS:GetColoredCharacterName(character), nameKey) )
			AltoTooltip:AddLine(" ")
			AltoTooltip:AddLine(L["Required reputation"] .. ":",1,1,1)
			
			
			
			local _,_,repEarned = DS:GetRawReputationInfo(character, repList[2])
			local progress
			if not repEarned then
				repEarned = 0
				progress=0
			else
				progress = repEarned/repList[1]
				progress = math.min(1,progress)
				progress = math.max(0,progress)
			end
			
			local repDone = progress >= 0.999 and 2 or 1
			local cr,cg,cb = 0.8, 0.1+0.8*progress, 0
			if repDone > 1 then cr,cg,cb = 0, 0.8, 0.8 end
			AltoTooltip:AddLine( format("%s %s (%d/%d)", ICON_LIST[repDone], tostring(repList[2]), repEarned, repList[1] ), cr,cg,cb )
			
			AltoTooltip:Show()
			return
		end
	end
	
end

function ns:Link_OnEnter(frame)
	-- print("Link_OnEnter(frame)")
	
	local parentFrame = frame:GetParent()
	if parentFrame.isHeader then return end
	local keyEntry = parentFrame.keyEntry
	if not keyEntry then return end
	
	local aquisition = keyEntry.aquisition
	local nameKey = keyEntry.name or "<?>"
	
	local notes 	-- currentFactionGroup
	if keyEntry.faction then
		notes = keyEntry.notes[currentFactionGroup]
	else
		notes = keyEntry.notes
	end
	if not notes then return end
	local notesLines = { strsplit("\n", notes) }
	
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	AltoTooltip:ClearLines()
	if keyEntry.faction then
		AltoTooltip:AddLine( ICON_LIST_FACTION[currentFactionGroup] .." ".. nameKey )
	else
		AltoTooltip:AddLine( nameKey )
	end
	AltoTooltip:AddLine(" ")
	
	for k,v in pairs(notesLines) do
		AltoTooltip:AddLine( "  "..v, 1,1,1, true )
	end
	if keyEntry.lockpick then
		AltoTooltip:AddLine(" ")
		AltoTooltip:AddLine( format(L["KEY_NOTE_Lockpick"], keyEntry.lockpick), 1,1,1 )
	end
	
	AltoTooltip:Show();
end

function ns:Item_OnClick(frame, button)
	-- print("Item_OnClick(frame, button)")
	-- if true then return end
	local charName = frame.CharName
	if not charName then return end
	local parentFrame = frame:GetParent()
	if parentFrame.isHeader then return end
	local keyEntry = parentFrame.keyEntry
	if not keyEntry then return end
	local aquisition = keyEntry.aquisition
	if not aquisition then return end
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	
	local charFaction = (DS:GetCharacterFaction(character) == "Alliance") and 1 or 2
	local itemID, itemLink
	
	if aquisition.type=="item" or aquisition.type=="questitem" or aquisition.type=="repitem" then
		if aquisition.faction then
			itemID = aquisition.item[charFaction]
		else
			itemID = aquisition.item
		end
	end
	if not itemID then return end
	if type(itemID) == "number" then
		itemLink = select(2, GetItemInfo(itemID))
	end
	if not itemLink then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			ChatEdit_ActivateChat(chat)
			chat:Insert(" "..itemLink)
		end
	end	
end

function ns:Link_OnClick(frame, button)
	-- print("Link_OnClick(frame, button)")
	
	local parentFrame = frame:GetParent()
	if not parentFrame.isHeader then return end
	
	local id = parentFrame:GetID()
	
	if id ~= 0 then
		-- print("Toggle Collapsing")
		collapsedHeaders[id] = not collapsedHeaders[id]
		ns:Update()
	end
	
end
