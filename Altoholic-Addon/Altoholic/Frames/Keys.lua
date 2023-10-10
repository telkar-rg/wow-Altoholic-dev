local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
-- local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local print = function(...) DEFAULT_CHAT_FRAME:AddMessage("\124cff00ccff{".. tostring(addonName) .. "-Keys}:\124r " .. strjoin("; ", tostringall(...))) end

local isViewValid
local collapsedHeaders

local ICON_DISABLED = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_ENABLED  = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

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
	[838] = "Scholomance",
	[964] = "Skeletal Fragments",
	[5092] = "Clear the Way",
	[5096] = "Scarlet Diversions",
	[5097] = "All Along the Watchtowers",
	[5098] = "All Along the Watchtowers",
	[5505] = "The Key to Scholomance",
	[5511] = "The Key to Scholomance",
	[5514] = "Mold Rhymes With...",
	[5533] = "Scholomance",
	[5537] = "Skeletal Fragments",
	[5538] = "Mold Rhymes With...",
	[5801] = "Fire Plume Forged",
	[5802] = "Fire Plume Forged",
	[5803] = "Araj's Scarab",
	[5804] = "Araj's Scarab",
	[7487] = "Attunement to the Core",
	[7761] = "Blackhand's Command",
	[7848] = "Attunement to the Core",
	
	[9824] = "Arcane Disturbances",
	[9825] = "Restless Activity",
	[9826] = "Contact from Dalaran",
	[9829] = "Khadgar",
	[9831] = "Entry Into Karazhan",
	[9832] = "The Second and Third Fragments",
	[9836] = "The Master's Touch",
	[9837] = "Return to Khadgar",
	
	[10754] = "Entry Into the Citadel",
	[10755] = "Entry Into the Citadel",
	[10756] = "Grand Master Rohok",
	[10757] = "Rohok's Request",
	[10758] = "Hotter than Hell",
	[10762] = "Grand Master Dumphry",
	[10763] = "Dumphry's Request",
	[10764] = "Hotter than Hell",
	
	[10263] = "Assisting the Consortium (Aldor)",
	[10264] = "Assisting the Consortium (Scryers)",
	[10265] = "Consortium Crystal Collection",
	[10262] = "A Heap of Ethereals",
	[10205] = "Warp-Raider Nesaad",
	[10266] = "Request for Assistance",
	[10267] = "Rightful Repossession",
	[10268] = "An Audience with the Prince",
	[10269] = "Triangulation Point One",
	[10275] = "Triangulation Point Two",
	[10276] = "Full Triangle",
	[10280] = "Special Delivery to Shattrath City",
	[10704] = "How to Break Into the Arcatraz",
	
	[10279] = "To The Master's Lair",
	[10277] = "The Caverns of Time",
	[10282] = "Old Hillsbrad",
	[10283] = "Taretha's Diversion",
	[10284] = "Escape from Durnholde",
	[10285] = "Return to Andormu",
	
	[11481] = "Crisis at the Sunwell",
	[11488] = "Magisters' Terrace",
	[11490] = "The Scryer's Scryer",
	[11492] = "Hard to Kill",
	
	[13604] = "Archivum Data Disc (10)",
	[13607] = "The Celestial Planetarium (10)",
	[13606] = "Freya's Sigil (10)",
	[13609] = "Hodir's Sigil (10)",
	[13610] = "Thorim's Sigil (10)",
	[13611] = "Mimiron's Sigil (10)",
	[13614] = "Algalon (10)",
	
	[13817] = "Archivum Data Disc (25)",
	[13816] = "The Celestial Planetarium (25)",
	[13821] = "Freya's Sigil (25)",
	[13822] = "Hodir's Sigil (25)",
	[13823] = "Thorim's Sigil (25)",
	[13824] = "Mimiron's Sigil (25)",
	[13818] = "Algalon (25)",
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
		name = "Heroic: "..BZ["Hellfire Citadel"],
		-- notes = L["KEY_NOTE_HellfireCitadel"], 
		aquisition = { 
			type="item", 
			faction=true, 
			item={30622,30637}
		},
		icon = "inv_misc_key_13"
	}, 	-- Flamewrought Key
	{ 
		name = "Heroic: "..BZ["Coilfang Reservoir"],
		-- notes = L["KEY_NOTE_CoilfangReservoir"], 
		aquisition = { type="item", item=30623 },
		icon = "inv_misc_key_13"
	}, 	-- Reservoir Key
	{
		name = "Heroic: "..BZ["Auchindoun"],
		-- notes = L["KEY_NOTE_Auchindoun"], 
		aquisition = { type="item", item=30633 },
		icon = "inv_misc_key_11"
	}, 	-- Auchenai Key
	{
		name = "Heroic: "..BZ["Tempest Keep"],
		-- notes = L["KEY_NOTE_TempestKeep"], 
		aquisition = { type="item", item=30634 },
		icon = "inv_misc_key_09"
	}, 	-- Warpforged Key
	{
		name = "Heroic: "..BZ["Caverns of Time"],
		-- notes = L["KEY_NOTE_CavernsofTime"], 
		aquisition = { type="item", item=30635 },
		icon = "inv_misc_key_04"
	}, 	-- Key of Time
	
	{
		name = "Heroic: "..BZ["Magisters' Terrace"],
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
	print("Update")
	-- local character = addon.Tabs.Characters:GetCurrent()

	
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
	print("offset",offset)
	
	-- for line = 1, DS:GetQuestLogSize(character) do
	for line, keyEntry in pairs(KeyList) do
		-- local isHeader, quest, questTag, groupSize, money, isComplete = DS:GetQuestLogInfo(character, line)
		local isHeader = not(keyEntry.aquisition)
		-- local name = keyEntry.name or "<?>"
		local name = tostring(line).." ".. (keyEntry.name or "<?>") 	-- DEBUG
		local icon = keyEntry.icon or "inv_misc_questionmark"
		local aquisition = keyEntry.aquisition
		print("--",
		"line",line,
		"name",name,
		"offset",offset,
		"VisibleCount",VisibleCount,
		"isHeader",isHeader)
		
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
			if isHeader then
			do -- DEBUG - remove later
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
			end
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()
				
				-- local _, _, level = DS:GetQuestInfo(quest)
				-- quick fix, level may be nil, I suspect that due to certain locales, the quest link may require different parsing.
				-- level = level or 0
				
				_G[entry..i.."EntryLinkText"]:SetText( name )
				-- _G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."EntryLink"]:SetID(line)
				_G[entry..i.."EntryLink"]:SetPoint("TOPLEFT", 10, 0)
				
				
				for j = 1, 10 do	-- loop through the 10 alts
					local itemName = entry.. i .. "Item" .. j;
					local itemButton = _G[itemName]
					local classButton = _G["AltoholicFrameClassesItem" .. j]
					
					local itemTexture = _G[itemName .. "_Background"]
					itemTexture:SetTexture("Interface\\Icons\\"..icon)

					local status, charFaction, itemBags, itemBank, searchedID, questList, questHistory, progress
					
					if classButton.CharName then	-- if there's an alt in this column..
						itemButton.CharName = classButton.CharName
						
						-- if character then wipe(character) end
						if questList then wipe(questList) end
						if questHistory then wipe(questHistory) end
						character = DS:GetCharacter(classButton.CharName, realm, account)
						charFaction = (DS:GetCharacterFaction(character) == "Alliance") and 1 or 2
						questHistory = DS:GetQuestHistory(character) or {}
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
							if questHistory[questList[#questList]] then 	-- if the last quest is done, then we are active
								status = true
							else 	-- else: we calculate the quest progress 
								progress = 0
								for _,questID in pairs(questList) do
									if questHistory[questID] then progress=progress+1 end
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
								if questHistory[questList[#questList]] then 	-- if the last quest is done, then we are active
									status = true
								else 	-- else: we calculate the quest progress 
									progress = 0
									for _,questID in pairs(questList) do
										if questHistory[questID] then progress=progress+1 end
									end
									progress = progress / #questList
								end
							end
						end
						
						local vc, text
						if status then 
							vc = VertexColors["WHITE"]
							itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
							
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 5, 0)
							
							_G[itemName .. "Name"]:SetText( ICON_ENABLED )
						elseif progress > 0 then
							vc = VertexColors["ORANGE"]
							itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
							
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", -5, 0)
							
							text = format("%2d", floor(progress*100+0.5)) .. "%"
							_G[itemName .. "Name"]:SetText( text )
							
						else
							vc = VertexColors["GRAY"]
							itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
							
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 5, 0)
							
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
	print("InvalidateView")
	isViewValid = nil
end


function ns:Collapse_OnClick(frame, button)
	print("Collapse_OnClick(frame, button)")
	if true then return end
	
	local id = frame:GetParent():GetID()
	if id ~= 0 then
		collapsedHeaders[id] = not collapsedHeaders[id]
		ns:Update()
	end
end

function ns:Item_OnEnter(frame)
	print("Item_OnEnter(frame)")
	if true then return end
end

function ns:Link_OnEnter(frame)
	print("Link_OnEnter(frame)")
	if true then return end
	
	local id = frame:GetID()
	if id == 0 then return end

	local DS = DataStore
	local character = addon.Tabs.Characters:GetCurrent()
	local _, link = DS:GetQuestLogInfo(character, id)
	if not link then return end

	local questName, questID, level = DS:GetQuestInfo(link)
	if IsAddOnLoaded("Odyssey") and IsAddOnLoaded("OdysseyQuests") then
		Odyssey:ShowQuestTooltip(frame, questID)
		return
	end
	
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	GameTooltip:SetHyperlink(link);
	GameTooltip:AddLine(" ",1,1,1);
	
	GameTooltip:AddDoubleLine(LEVEL .. ": |cFF00FF9A" .. level, L["QuestID"] .. ": |cFF00FF9A" .. questID);
	
	local player = addon:GetCurrentCharacter()
	addon.Quests:ListCharsOnQuest(questName, player, GameTooltip)
	GameTooltip:Show();
end

function ns:Item_OnClick(frame, button)
	print("Item_OnClick(frame, button)")
	if true then return end
end
function ns:Link_OnClick(frame, button)
	print("Link_OnClick(frame, button)")
	if true then return end
	
	if button == "LeftButton" and IsShiftKeyDown() then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local id = frame:GetID()
			if id == 0 then return end
			
			local character = addon.Tabs.Characters:GetCurrent()
			local _, link = DataStore:GetQuestLogInfo(character, id)
			if link then
				chat:Insert(link)
			end
		end
	end
end
