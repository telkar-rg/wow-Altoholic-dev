﻿local addonName = ...
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local TEAL		= "|cFF00FF9A"
local GOLD		= "|cFFFFD700"
local IMPOSSIBLE_DIFFICULTY_COLOR = "|cffff2020"

local THIS_ACCOUNT = "Default"

local Orig_GameTooltip_OnShow
local Orig_GameTooltip_SetItem
local Orig_GameTooltip_ClearItem
-- local Orig_GameTooltip_SetSpell

local Orig_ItemRefTooltip_OnShow
local Orig_ItemRefTooltip_SetItem
local Orig_ItemRefTooltip_ClearItem
-- local Orig_ItemRefTooltip_SetSpell

local GatheringNodes = {			-- Add herb/ore possession info to Plants/Mines, thanks to Tempus on wowace for gathering this.

	-- Mining nodes
	[L["Adamantite Deposit"]]              = 23425, -- Adamantite Ore
	[L["Copper Vein"]]                     =  2770, -- Copper Ore
	[L["Dark Iron Deposit"]]               = 11370, -- Dark Iron Ore
	[L["Fel Iron Deposit"]]                = 23424, -- Fel Iron Ore
	[L["Gold Vein"]]                       =  2776, -- Gold Ore
	[L["Hakkari Thorium Vein"]]            = 10620, -- Thorium Ore
	[L["Iron Deposit"]]                    =  2772, -- Iron Ore
	[L["Khorium Vein"]]                    = 23426, -- Khorium Ore
	[L["Mithril Deposit"]]                 =  3858, -- Mithril Ore
	[L["Ooze Covered Gold Vein"]]          =  2776, -- Gold Ore
	[L["Ooze Covered Mithril Deposit"]]    =  3858, -- Mithril Ore
	[L["Ooze Covered Rich Thorium Vein"]]  = 10620, -- Thorium Ore
	[L["Ooze Covered Silver Vein"]]        =  2775, -- Silver Ore
	[L["Ooze Covered Thorium Vein"]]       = 10620, -- Thorium Ore
	[L["Ooze Covered Truesilver Deposit"]] =  7911, -- Truesilver Ore
	[L["Rich Adamantite Deposit"]]         = 23425, -- Adamantite Ore
	[L["Rich Thorium Vein"]]               = 10620, -- Thorium Ore
	[L["Silver Vein"]]                     =  2775, -- Silver Ore
	[L["Small Thorium Vein"]]              = 10620, -- Thorium Ore
	[L["Tin Vein"]]                        =  2771, -- Tin Ore
	[L["Truesilver Deposit"]]              =  7911, -- Truesilver Ore

	[L["Lesser Bloodstone Deposit"]]       =  4278, -- Lesser Bloodstone Ore
	[L["Incendicite Mineral Vein"]]        =  3340, -- Incendicite Ore
	[L["Indurium Mineral Vein"]]           =  5833, -- Indurium Ore
	[L["Nethercite Deposit"]]              = 32464, -- Nethercite Ore
	[L["Large Obsidian Chunk"]]				= 22203,	-- Large Obsidian Shard	Both drop on both nodes..
	[L["Small Obsidian Chunk"]]				= 22202,	-- Small Obsidian Shard
	
	-- wotlk
	["Cobalt Deposit"]							= 36909, -- Cobalt Ore
	["Rich Cobalt Deposit"]						= 36909, -- Cobalt Ore
	["Saronite Deposit"]							= 36912, -- Saronite Ore
	["Rich Saronite Deposit"]					= 36912, -- Saronite Ore
	["Titanium Vein"]								= 36910, -- Titanium Ore

	-- Herbs
	[L["Ancient Lichen"]]       = 22790,
	[L["Arthas' Tears"]]        =  8836,
	[L["Black Lotus"]]          = 13468,
	[L["Blindweed"]]            =  8839,
	[L["Bloodthistle"]]         = 22710,
	[L["Briarthorn"]]           =  2450,
	[L["Bruiseweed"]]           =  2453,
	[L["Dreamfoil"]]            = 13463,
	[L["Dreaming Glory"]]       = 22786,
	[L["Earthroot"]]            =  2449,
	[L["Fadeleaf"]]             =  3818,
	[L["Felweed"]]              = 22785,
	[L["Firebloom"]]            =  4625,
	[L["Flame Cap"]]            = 22788,
	[L["Ghost Mushroom"]]       =  8845,
	[L["Golden Sansam"]]        = 13464,
	[L["Goldthorn"]]            =  3821,
	[L["Grave Moss"]]           =  3369,
	[L["Gromsblood"]]           =  8846,
	[L["Icecap"]]               = 13467,
	[L["Khadgar's Whisker"]]    =  3358,
	[L["Kingsblood"]]           =  3356,
	[L["Liferoot"]]             =  3357,
	[L["Mageroyal"]]            =   785,
	[L["Mana Thistle"]]         = 22793,
	[L["Mountain Silversage"]]  = 13465,
	[L["Netherbloom"]]          = 22791,
	[L["Nightmare Vine"]]       = 22792,
	[L["Peacebloom"]]           =  2447,
	[L["Plaguebloom"]]          = 13466,
	[L["Purple Lotus"]]         =  8831,
	[L["Ragveil"]]              = 22787,
	[L["Silverleaf"]]           =   765,
	[L["Stranglekelp"]]         =  3820,
	[L["Sungrass"]]             =  8838,
	[L["Terocone"]]             = 22789,
	[L["Wild Steelbloom"]]      =  3355,
	[L["Wintersbite"]]          =  3819,

	[L["Glowcap"]]              = 24245,
	[L["Netherdust Bush"]]      = 32468, -- Netherdust Pollen
	[L["Sanguine Hibiscus"]]    = 24246,

	["Fel Lotus"]					= 22794,
	["Goldclover"]					= 36901,
	["Adder's Tongue"]			= 36903,
	["Tiger Lily"]					= 36904,
	["Lichbloom"]					= 36905,
	["Icethorn"]					= 36906,
	["Talandra's Rose"]			= 36907,
	["Frost Lotus"]				= 36908,
	["Firethorn"]					= 39970,
}

local QuestStartItemList = {
	[51315] = 24914,  -- Sealed Chest
	[50380] = 24554,  -- Battered Hilt
	[50379] = 14443,  -- Battered Hilt
	[49644] = 24428,  -- Head of Onyxia
	[49643] = 24429,  -- Head of Onyxia
	[47246] = 14160,  -- Writ of Merit
	[46053] = 13819,  -- Reply-Code Alpha
	[46052] = 13631,  -- Reply-Code Alpha
	[45857] = 13817,  -- Archivum Data Disc
	[45506] = 13604,  -- Archivum Data Disc
	[44577] = 13375,  -- Heroic Key to the Focusing Iris
	[44569] = 13372,  -- Key to the Focusing Iris
	[33102] = 11178,  -- Blood of Zul'jin
	[32405] = 11007,  -- Verdant Sphere
	[32386] = 11003,  -- Magtheridon's Head
	[32385] = 11002,  -- Magtheridon's Head
	[21751] = 8536,  -- Tactical Task Briefing III
	[21750] = 8771,  -- Combat Task Briefing II
	[21749] = 8770,  -- Combat Task Briefing I
	[21514] = 8829,  -- Logistics Task Briefing XI
	[21385] = 8810,  -- Logistics Task Briefing X
	[21384] = 8808,  -- Logistics Task Briefing VIII
	[21382] = 8807,  -- Logistics Task Briefing V
	[21381] = 8809,  -- Logistics Task Briefing IX
	[21380] = 8806,  -- Logistics Task Briefing III
	[21379] = 8805,  -- Logistics Task Briefing II
	[21378] = 8804,  -- Logistics Task Briefing I
	[21265] = 8783,  -- Logistics Task Briefing IX
	[21264] = 8787,  -- Logistics Task Briefing VII
	[21263] = 8780,  -- Logistics Task Briefing VII
	[21262] = 8782,  -- Logistics Task Briefing VIII
	[21261] = 8786,  -- Logistics Task Briefing VI
	[21260] = 8781,  -- Logistics Task Briefing VI
	[21259] = 8779,  -- Logistics Task Briefing V
	[21258] = 8785,  -- Logistics Task Briefing IV
	[21257] = 8778,  -- Logistics Task Briefing IV
	[21256] = 8777,  -- Combat Task Briefing XI
	[21255] = 8776,  -- Combat Task Briefing X
	[21253] = 8775,  -- Combat Task Briefing IX
	[21252] = 8774,  -- Combat Task Briefing VIII
	[21251] = 8687,  -- Combat Task Briefing VII
	[21250] = 8772,  -- Combat Task Briefing VI
	[21249] = 8539,  -- Combat Task Briefing V
	[21248] = 8773,  -- Combat Task Briefing IV
	[21245] = 8737,  -- Tactical Task Briefing I
	[21221] = 8801,  -- Eye of C'Thun
	[21220] = 8791,  -- Head of Ossirian the Unscarred
	[21167] = 8739,  -- Tactical Task Briefing VIII
	[21166] = 8738,  -- Tactical Task Briefing VII
	[21165] = 8534,  -- Tactical Task Briefing VI
	[20948] = 8538,  -- Tactical Task Briefing V
	[20947] = 8535,  -- Tactical Task Briefing IV
	[20945] = 8537,  -- Tactical Task Briefing II
	[20944] = 8740,  -- Tactical Task Briefing IX
	[20943] = 8498,  -- Tactical Task Briefing X
	[20942] = 8502,  -- Combat Task Briefing III
	[20941] = 8501,  -- Combat Task Briefing XII
	[20940] = 8541,  -- Logistics Task Briefing III
	[20939] = 8540,  -- Logistics Task Briefing II
	[20807] = 8497,  -- Logistics Task Briefing I
	[20806] = 8496,  -- Logistics Task Briefing X
	[20644] = 8446,  -- Nightmare Engulfed Object
	[19802] = 8183,  -- Heart of Hakkar
	[19018] = 7787,  -- Dormant Wind Kissed Blade
	[19016] = 7785,  -- Vessel of Rebirth
	[19003] = 7781,  -- Head of Nefarian
	[19002] = 7783,  -- Head of Nefarian
	[18771] = 7651,  -- Enchanted Thorium Platemail
	[18770] = 7650,  -- Enchanted Thorium Platemail
	[18769] = 7649,  -- Enchanted Thorium Platemail
	[18706] = 7810,  -- Arena Master
	[18703] = 7632,  -- Ancient Petrified Leaf
	[18628] = 7604,  -- Thorium Brotherhood Contract
	[18423] = 7495,  -- Head of Onyxia
	[18422] = 7490,  -- Head of Onyxia
	[18364] = 7506,  -- The Emerald Dream
	[18363] = 7505,  -- Frost Shock and You
	[18362] = 7504,  -- Holy Bologna: What the Light Won't Tell You
	[18361] = 7503,  -- The Greatest Race of Hunters
	[18360] = 7502,  -- Harnessing Shadows
	[18359] = 7501,  -- The Light and How to Swing It
	[18358] = 7500,  -- The Arcanist's Cookbook
	[18357] = 7499,  -- Codex of Defense
	[18356] = 7498,  -- Garona: A Study on Stealth and Treachery
	[16782] = 6922,  -- Strange Water Globe
	[16408] = 1918,  -- Befouled Water Globe
	[16305] = 2,  -- Sharptalon's Claw
	[16304] = 24,  -- Shadumbra's Head
	[16303] = 23,  -- Ursangous's Paw
	[13140] = 5202,  -- Blutroter Schlüssel
	[11463] = 4281,  -- Undelivered Parcel
	[11116] = 3884,  -- A Mangled Journal
	[10454] = 3373,  -- Essence of Eranikus
	[8705] = 2766,  -- OOX-22/FE Distress Beacon
	[8704] = 485,  -- OOX-09/HL Distress Beacon
	[8623] = 351,  -- OOX-17/TN Distress Beacon
	[8524] = 654,  -- Model 4711-FTZ Power Source
	[7666] = 2198,  -- Shattered Necklace
	[4614] = 635,  -- Pendant of Myzrael
	[3985] = 8552,  -- Monogrammed Sash
	[6196] = 1392,  -- Noboru's Cudgel
}

local ItemNoteText = {
	[9303] = L["Any Alchemist's Stone can be used for Alchemical Transmutation!"], 	-- Recipe: Philosopher's Stone
	[9149] = L["Any Alchemist's Stone can be used for Alchemical Transmutation!"], 	-- Philosopher's Stone
	
	[13503] = L["Required for Alchemical Transmutation."], 	-- Alchemist's Stone
	[13517] = L["Required for Alchemical Transmutation."],	-- Recipe: Alchemist's Stone
	
	[35748] = L["Required for Alchemical Transmutation."], 	-- Guardian's Alchemist Stone
	[35749] = L["Required for Alchemical Transmutation."], 	-- Sorcerer's Alchemist Stone
	[35750] = L["Required for Alchemical Transmutation."], 	-- Redeemer's Alchemist Stone
	[35751] = L["Required for Alchemical Transmutation."], 	-- Assassin's Alchemist Stone
	[35752] = L["Required for Alchemical Transmutation."],	-- Recipe: Guardian's Alchemist Stone
	[35753] = L["Required for Alchemical Transmutation."],	-- Recipe: Sorcerer's Alchemist Stone
	[35754] = L["Required for Alchemical Transmutation."],	-- Recipe: Redeemer's Alchemist Stone
	[35755] = L["Required for Alchemical Transmutation."],	-- Recipe: Assassin's Alchemist Stone
	
	[44322] = L["Required for Alchemical Transmutation."], 	-- Mercurial Alchemist Stone
	[44323] = L["Required for Alchemical Transmutation."], 	-- Indestructible Alchemist's Stone
	[44324] = L["Required for Alchemical Transmutation."], 	-- Mighty Alchemist's Stone
}

-- *** Utility functions ***
local function IsGatheringNode(name)
	if name then
		for k, v in pairs(GatheringNodes) do
			if name == k then				-- returns the itemID if "name" is a known type of gathering node (mines & herbs)
				return v
			end
		end
	end
end

local function GetCraftNameFromRecipeLink(link)
	-- get the craft name from the itemlink (strsplit on | to get the 4th value, then split again on ":" )
	local recipeName = select(4, strsplit("|", link))
	local craftName

	-- try to determine if it's a transmute (has 2 colons in the string --> Alchemy: Transmute: blablabla)
	local pos = string.find(recipeName, L["Transmute"])
	if pos then	-- it's a transmute
		return string.sub(recipeName, pos, -2)
	else
		craftName = select(2, strsplit(":", recipeName))
	end
	
	if craftName == nil then		-- will be nil for enchants
		return string.sub(recipeName, 3, -2)		-- ex: "Enchant Weapon - Striking"
	end
	
	return string.sub(craftName, 2, -2)	-- at this point, get rid of the leading space and trailing square bracket
end

local isTooltipDone, isNodeDone			-- for informant
local cachedItemID, cachedCount, cachedTotal, cachedSource, cachedNote, cachedQuestStartItem
local cachedRecipeOwners

local itemCounts = {}
local itemCountsLabels = {	L["Bags"], L["Bank"], L["AH"], L["Equipped"], L["Mail"], CURRENCY }
local counterLines = {}		-- list of lines containing a counter to display in the tooltip

local function AddCounterLine(owner, counters)
	table.insert(counterLines, { ["owner"] = owner, ["info"] = counters } )
end

local function WriteCounterLines(tooltip)
	if #counterLines == 0 then return end

	if (addon.Options:Get("TooltipCount") == 1) then			-- add count per character/guild
		tooltip:AddLine(" ",1,1,1);
		for _, line in ipairs (counterLines) do
			tooltip:AddDoubleLine(line.owner,  TEAL .. line.info);
		end
	end
end

local function WriteTotal(tooltip)
	if (addon.Options:Get("TooltipTotal") == 1) and cachedTotal then
		tooltip:AddLine(cachedTotal,1,1,1);
	end
end

local function GetCharacterItemCount(character, searchedID)
	itemCounts[1], itemCounts[2] = DataStore:GetContainerItemCount(character, searchedID)
	itemCounts[3] = DataStore:GetAuctionHouseItemCount(character, searchedID)
	itemCounts[4] = DataStore:GetInventoryItemCount(character, searchedID)
	itemCounts[5] = DataStore:GetMailItemCount(character, searchedID)
	itemCounts[6] = DataStore:GetCurrencyItemCount(character, searchedID)
	
	if searchedID==6948 then return 0 end
	if searchedID==43523 then return 0 end
	
	local charCount = 0
	for _, v in pairs(itemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local account, _, char = strsplit(".", character)
		local name = DataStore:GetColoredCharacterName(character) or char		-- if for any reason this char isn't in DS_Characters.. use the name part of the key
		if account ~= THIS_ACCOUNT then
			name = name .. YELLOW .. " (" .. account .. ")"
		end
		
		local t = {}
		for k, v in pairs(itemCounts) do
			if v > 0 then	-- if there are more than 0 items in this container
				table.insert(t, WHITE .. itemCountsLabels[k] .. ": "  .. TEAL .. v)
			end
		end

		-- charInfo should look like 	(Bags: 4, Bank: 8, Equipped: 1, Mail: 7), table concat takes care of this
		AddCounterLine(name, format("%s (%s%s)", ORANGE .. charCount .. WHITE, table.concat(t, WHITE..", "), WHITE))
	end
	
	return charCount
end

local function GetAccountItemCount(account, searchedID)
	local realm = GetRealmName()		-- implicit: this realm only
	local count = 0

	for _, character in pairs(DataStore:GetCharacters(realm, account)) do
		if addon.Options:Get("TooltipCrossFaction") == 1 then
			count = count + GetCharacterItemCount(character, searchedID)
		else
			if	DataStore:GetCharacterFaction(character) == UnitFactionGroup("player") then
				count = count + GetCharacterItemCount(character, searchedID)
			end
		end
	end
	return count
end

local function GetItemCount(searchedID)
	-- Return the total amount of times an item is present on this realm, and prepares the counterLines table for later display by the tooltip
	wipe(counterLines)

	local count = 0
	if addon.Options:Get("TooltipMultiAccount") == 1 and not addon.Comm.Sharing.SharingInProgress then
		for account in pairs(DataStore:GetAccounts()) do
			count = count + GetAccountItemCount(account, searchedID)
		end
	else
		count = GetAccountItemCount(THIS_ACCOUNT, searchedID)
	end
		
	if addon.Options:Get("TooltipGuildBank") == 1 then
		for guildName, guildKey in pairs(DataStore:GetGuilds(GetRealmName())) do				-- this realm only
			local altoGuild = addon:GetGuild(guildName)
			if not altoGuild or (altoGuild and not altoGuild.hideInTooltip) then
				local guildCount = 0
				
				if addon.Options:Get("TooltipGuildBankCountPerTab") == 1 then
					local tabCounters = {}
					
					for tabID = 1, 6 do 
						local tabCount = DataStore:GetGuildBankTabItemCount(guildKey, tabID, searchedID)
						if tabCount > 0 then
							table.insert(tabCounters,  format("%s: %s", WHITE .. DataStore:GetGuildBankTabName(guildKey, tabID), TEAL..tabCount))
						end
					end
					
					if #tabCounters > 0 then
						guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID)
						AddCounterLine(GREEN..guildName, format("%s %s(%s%s)", ORANGE .. guildCount, WHITE, table.concat(tabCounters, ","), WHITE))
					end
				else
					guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID)
					if guildCount > 0 then
						AddCounterLine(GREEN..guildName, format("%s(%s: %s%s)", WHITE, GUILD_BANK, TEAL..guildCount, WHITE))
					end
				end
					
				if addon.Options:Get("TooltipGuildBankCount") == 1 then
					count = count + guildCount
				end
			end
		end
	end

	return count
end

local function GetRecipeOwners(professionName, link, recipeLevel)
	local craftName
	local spellID = addon:GetSpellIDFromRecipeLink(link)
	
	if not spellID then		-- spell id unknown ? let's parse the tooltip
		if true then return end
		craftName = GetCraftNameFromRecipeLink(link)
		if not craftName then return end		-- still nothing usable ? then exit
	end
	
	
	local know = {}				-- list of alts who know this recipe
	local couldLearn = {}		-- list of alts who could learn it
	local willLearn = {}			-- list of alts who will be able to learn it later

	local profession, isKnownByChar
	for characterName, character in pairs(DataStore:GetCharacters()) do
		profession = DataStore:GetProfession(character, professionName)

		if profession then
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				isKnownByChar = DataStore:IsCraftKnown(profession, spellID)
			else
				for i = 1, DataStore:GetNumCraftLines(profession) do
					local isHeader, _, info = DataStore:GetCraftLineInfo(profession, i)
					
					if not isHeader then
						local skillName = GetSpellInfo(info) or ""

						if string.lower(skillName) == string.lower(craftName) then
							isKnownByChar = true
							break
						end				
					end
				end
			end

			local coloredName = DataStore:GetColoredCharacterName(character)
			
			if isKnownByChar then
				table.insert(know, coloredName)
			else
				local currentLevel = DataStore:GetSkillInfo(character, professionName)
				if currentLevel > 0 then
					if currentLevel < recipeLevel then
						table.insert(willLearn, format("%s |r(%d)", coloredName, currentLevel))
					else
						table.insert(couldLearn, format("%s |r(%d)", coloredName, currentLevel))
					end
				end
			end
		end
	end
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", ") .."\n")
	end
	
	if #couldLearn > 0 then
		table.insert(lines, YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", ") .."\n")
	end
	
	if #willLearn > 0 then
		table.insert(lines, RED .. L["Will be learnable by "] ..": ".. WHITE.. table.concat(willLearn, ", "))
	end
	
	return table.concat(lines, "\n")
end

local function AddPetOwners(companionSpellID, companionType, tooltip)
	local know = {}				-- list of alts who know this pet
	local couldLearn = {}		-- list of alts who could learn it

	for characterName, character in pairs(DataStore:GetCharacters()) do
		if DataStore:IsPetKnown(character, companionType, companionSpellID) then
			table.insert(know, characterName)
		else
			table.insert(couldLearn, characterName)
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", "), 1, 1, 1, 1);
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", "), 1, 1, 1, 1);
	end
end

local function ShowGatheringNodeCounters()
	-- exit if player does not want counters for known gathering nodes
	if addon.Options:Get("TooltipGatheringNode") == 0 then return end

	local itemID = IsGatheringNode( _G["GameTooltipTextLeft1"]:GetText() )
	if not itemID or (itemID == cachedItemID) then return end					-- is the item in the tooltip a known type of gathering node ?
	
	if Informant then
		isNodeDone = true
	end

	-- check player bags to see how many times he owns this item, and where
	if addon.Options:Get("TooltipCount") == 1 or addon.Options:Get("TooltipTotal") == 1 then
		cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
		cachedTotal = (cachedCount > 0) and format("%s: %s", GOLD..L["Total owned"], TEAL..cachedCount) or nil
	end
	
	WriteCounterLines(GameTooltip)
	WriteTotal(GameTooltip)
end

local function ProcessTooltip(tooltip, name, link)
	if Informant and isNodeDone then
		return
	end
	
	local itemID = addon:GetIDFromLink(link)
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	
	-- if there's no cached item id OR if it's different from the previous one ..
	if (not cachedItemID) or (cachedItemID and (itemID ~= cachedItemID)) then

		cachedRecipeOwners = nil
		
		-- these are the cpu intensive parts of the update .. so do them only if necessary
		cachedSource = nil
		cachedNote = nil
		if addon.Options:Get("TooltipSource") == 1 then
			local Instance, Boss
			local Instance_Boss = addon.Loots:GetSource_multi(itemID)
			if not Instance_Boss then
				Instance, Boss = addon.Loots:GetSource(itemID)
				if Instance then
					Instance_Boss = format("%s, %s", Instance, Boss)
				end
			end
			
			cachedItemID = itemID			-- we have searched this ID ..
			if Instance_Boss then
				cachedSource = format("%s: %s", GOLD..L["Source"], TEAL..Instance_Boss)
			end
			
			local cNote = ItemNoteText[itemID]
			if cNote then
			cachedNote = format('|cFFFFFFFF%s:|r "%s"', L["Note"], cNote)
			end
		end
		
		cachedQuestStartItem = nil
		if addon.Options:Get("TooltipQuestStartItem") == 1 and QuestStartItemList[itemID] then
			-- UnitName("player")
			local character = DS:GetCharacter(UnitName("player"), realm, account)
			if DS:IsQuestCompletedBy(character, QuestStartItemList[itemID] ) then
				-- cachedQuestStartItem = RED.."Quest already completed."
				cachedQuestStartItem = format("<%s%s|r>", IMPOSSIBLE_DIFFICULTY_COLOR, QUEST_COMPLETE)
			end
			cachedItemID = itemID			-- we have searched this ID ..
		end
		
		-- .. then check player bags to see how many times he owns this item, and where
		if addon.Options:Get("TooltipCount") == 1 or addon.Options:Get("TooltipTotal") == 1 then
			cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
			cachedTotal = (cachedCount > 0) and format("%s: %s", GOLD..L["Total owned"], TEAL..cachedCount) or nil
		end
	end

	-- add item cooldown text
	local owner = tooltip:GetOwner()
	if owner and owner.startTime then
		tooltip:AddLine(format(ITEM_COOLDOWN_TIME, SecondsToTime(owner.duration - (GetTime() - owner.startTime))),1,1,1);
	end
	
	if cachedQuestStartItem then		-- add cachedQuestStartItem
		-- tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(cachedQuestStartItem,1,1,1);
	end

	WriteCounterLines(tooltip)
	WriteTotal(tooltip)
	
	
	if cachedSource then		-- add item source
		tooltip:AddLine(" ",1,1,1);
		
		if cachedNote then-- add item Notes to Sources
			tooltip:AddLine(cachedNote,1,1,0,1); 	-- yellow
		end
		tooltip:AddLine(cachedSource,1,1,1,1);
	end
	
	-- addon:CheckMaterialUtility(itemID)
	
	if addon.Options:Get("TooltipItemID") == 1 then
		local iLevel = select(4, GetItemInfo(itemID))
		
		if iLevel then
			tooltip:AddLine(" ",1,1,1);
			tooltip:AddDoubleLine("Item ID: " .. GREEN .. itemID,  "iLvl: " .. GREEN .. iLevel);
--			tooltip:AddLine(TEAL .. select(10, GetItemInfo(itemID)));		-- texture path
		end
	end
	
	if DataStore:IsModuleEnabled("DataStore_Pets") and addon.Options:Get("TooltipPetInfo") == 1 then
		local companionID = DataStore:GetCompanionSpellID(itemID)
		if companionID then
			tooltip:AddLine(" ",1,1,1);	
			AddPetOwners(companionID, "CRITTER", tooltip)
			return	-- it's certainly not a recipe if we passed here
		end
		
		local mountID = DataStore:GetMountSpellID(itemID)
		if mountID then
			tooltip:AddLine(" ",1,1,1);	
			AddPetOwners(mountID, "MOUNT", tooltip)
			return	-- it's certainly not a recipe if we passed here
		end
	end
	
	if addon.Options:Get("TooltipRecipeInfo") == 0 then return end -- exit if recipe information is not wanted
	
	local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
	if itemType ~= BI["Recipe"] then return end		-- exit if not a recipe
	if itemSubType == BI["Book"] then return end		-- exit if it's a book

	if not cachedRecipeOwners then
		local tooltipName = tooltip:GetName()
		local reqLevel
		for i = 2, tooltip:NumLines() do			-- parse all tooltip lines, one by one
			local tooltipText = _G[tooltipName .. "TextLeft" .. i]:GetText()
			if tooltipText then
				if string.find(tooltipText, "%d+") then	-- try to find a numeric value .. 
					reqLevel = tonumber(string.sub(tooltipText, string.find(tooltipText, "%d+")))
					break
				end
			end
		end
		cachedRecipeOwners = GetRecipeOwners(itemSubType, link, reqLevel)
	end
	
	if cachedRecipeOwners then
		tooltip:AddLine(" ",1,1,1);	
		tooltip:AddLine(cachedRecipeOwners, 1, 1, 1, 1);
	end	
end

local function Hook_LinkWrangler(frame)
	local name, link = frame:GetItem()
	if name and link then
		ProcessTooltip(frame, name, link)
	end
end

-- ** GameTooltip hooks **
local function OnGameTooltipShow(tooltip, ...)
	if Orig_GameTooltip_OnShow then
		Orig_GameTooltip_OnShow(tooltip, ...)
	end	
	
	ShowGatheringNodeCounters()
	GameTooltip:Show()
end

local function OnGameTooltipSetItem(tooltip, ...)
	if Orig_GameTooltip_SetItem then
		Orig_GameTooltip_SetItem(tooltip, ...)
	end
	
	if (not isTooltipDone) and tooltip then
		local name, link = tooltip:GetItem()
		isTooltipDone = true
		if link then
			ProcessTooltip(tooltip, name, link)
		end
	end
end

local function OnGameTooltipCleared(tooltip, ...)
	isTooltipDone = nil
	isNodeDone = nil		-- for informant
	return Orig_GameTooltip_ClearItem(tooltip, ...)
end

-- ** ItemRefTooltip hooks **
local function OnItemRefTooltipShow(tooltip, ...)
	if Orig_ItemRefTooltip_OnShow then
		Orig_ItemRefTooltip_OnShow(tooltip, ...)
	end

	addon.Quests:ListCharsOnQuest( _G["ItemRefTooltipTextLeft1"]:GetText(), UnitName("player"), ItemRefTooltip)
	ItemRefTooltip:Show()
end

local function OnItemRefTooltipSetItem(tooltip, ...)
	if Orig_ItemRefTooltip_SetItem then
		Orig_ItemRefTooltip_SetItem(tooltip, ...)
	end
	
	if (not isTooltipDone) and tooltip then
		local name, link = tooltip:GetItem()
		isTooltipDone = true
		if link then
			ProcessTooltip(tooltip, name, link)
		end
	end
end

local function OnItemRefTooltipCleared(tooltip, ...)
	isTooltipDone = nil
	return Orig_ItemRefTooltip_ClearItem(tooltip, ...)
end

function addon:InitTooltip()
	-- save all function pointers
	Orig_GameTooltip_OnShow = GameTooltip:GetScript("OnShow")
	Orig_GameTooltip_SetItem = GameTooltip:GetScript("OnTooltipSetItem")
	Orig_GameTooltip_ClearItem = GameTooltip:GetScript("OnTooltipCleared")
	-- Orig_GameTooltip_SetSpell = GameTooltip:GetScript("OnTooltipSetSpell")

	Orig_ItemRefTooltip_OnShow = ItemRefTooltip:GetScript("OnShow")
	Orig_ItemRefTooltip_SetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
	Orig_ItemRefTooltip_ClearItem = ItemRefTooltip:GetScript("OnTooltipCleared")
	-- Orig_ItemRefTooltip_SetSpell = ItemRefTooltip:GetScript("OnTooltipSetSpell")

	-- set new function pointers
	GameTooltip:SetScript("OnShow", OnGameTooltipShow)
	GameTooltip:SetScript("OnTooltipSetItem", OnGameTooltipSetItem)
	GameTooltip:SetScript("OnTooltipCleared", OnGameTooltipCleared)
	-- GameTooltip:SetScript("OnTooltipSetSpell", OnGameTooltipSetSpell)

	ItemRefTooltip:SetScript("OnShow", OnItemRefTooltipShow)
	ItemRefTooltip:SetScript("OnTooltipSetItem", OnItemRefTooltipSetItem)
	ItemRefTooltip:SetScript("OnTooltipCleared", OnItemRefTooltipCleared)
	-- ItemRefTooltip:SetScript("OnTooltipSetSpell", OnItemRefTooltipSetSpell)
	
	-- LinkWrangler supoprt
   if LinkWrangler then
      LinkWrangler.RegisterCallback ("Altoholic",  Hook_LinkWrangler, "refresh")
   end
end

function addon:RefreshTooltip()
	cachedItemID = nil	-- putting this at NIL will force a tooltip refresh in self:ProcessToolTip
end

function addon:GetItemCount(searchedID)
	-- "public" for other addons using it
	return GetItemCount(searchedID)
end

-- not yet implemented, still needs testing, basic stuff works, but far from being optimized.
-- function addon.Tooltip.OnGameTooltipSetSpell(tooltip, ...)
	-- local self = addon.Tooltip

	-- if self.Orig_GameTooltip_SetSpell then
		-- self.Orig_GameTooltip_SetSpell(tooltip, ...)
	-- end

	-- local _, _, spellID = tooltip:GetSpell()
	-- if spellID then
		-- local DS = DataStore
		-- for characterName, character in pairs(DataStore:GetCharacters(realm)) do
			-- for _, profession in pairs(DataStore:GetProfessions(character)) do
				-- if DataStore:IsCraftKnown(profession, spellID) then
					-- tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. characterName, 1, 1, 1, 1);
				-- end
			-- end
		-- end
		-- self:AddPetOwners(spellID, "CRITTER", tooltip)
		-- self:AddPetOwners(spellID, "MOUNT", tooltip)
	-- end
-- end

-- function addon.Tooltip.OnItemRefTooltipSetSpell(tooltip, ...)
	-- local self = addon.Tooltip

	-- if self.Orig_ItemRefTooltip_SetSpell then
		-- self.Orig_ItemRefTooltip_SetSpell(tooltip, ...)
	-- end

	-- local _, _, spellID = tooltip:GetSpell()
	-- if spellID then
		-- local DS = DataStore
		-- for characterName, character in pairs(DataStore:GetCharacters(realm)) do
			-- for _, profession in pairs(DataStore:GetProfessions(character)) do
				-- if DataStore:IsCraftKnown(profession, spellID) then
					-- tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. characterName, 1, 1, 1, 1);
				-- end
			-- end
		-- end
		-- self:AddPetOwners(spellID, "CRITTER", tooltip)
		-- self:AddPetOwners(spellID, "MOUNT", tooltip)
	-- end
-- end
