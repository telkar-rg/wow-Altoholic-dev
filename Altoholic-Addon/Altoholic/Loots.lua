local addonName, addonTable = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local lootTable, lootTableRev_Single, lootTableRev_Multi
local LootSourceTooltipDB = {}
local LootSourceTooltip_VERSION = 18.029


local DataProviders
local listSearchedID = {}

addon.Loots = {}

local ns = addon.Loots		-- ns = namespace


-- Simplified loot table containing item ID's only, based on AtlasLoot v5.09.00
lootTable = addonTable.LootTableSetup.lootTable



function ns:setupLootTable()
	local playerFaction = UnitFactionGroup("player")
	LootSourceTooltipDB = Altoholic.db.global.LootSourceTooltip[playerFaction]
	
	if not LootSourceTooltipDB.version or LootSourceTooltipDB.version ~= LootSourceTooltip_VERSION then
		
		
		local lootSecondary = { 	-- these items are only considered second after all other sources
			L["Emblem of Frost"],
			L["Emblem of Triumph"],
			L["Emblem of Conquest"],
			L["Emblems of Valor"],
			L["Emblems of Heroism"],
			L["Badge of Justice"],
			BZ["Vault of Archavon"],
		}
		local lootSecondaryCheck = {}
		for k,v in pairs(lootSecondary) do lootSecondaryCheck[v]= true; end
		
		
		
		local lastZone = {}
		local lootTable_names = {}
		
		for zName, _ in pairs(lootTable) do
			tinsert( lootTable_names, zName )
		end
		sort(lootTable_names)
		local zTable
		
		-- lootTableRev_Single = {}
		lootTableRev_Multi = {}
		-- PRIMARY
		for _, zName in pairs(lootTable_names) do
			if not lootSecondaryCheck[zName] then	-- check primary sources first
				zTable = lootTable[zName]
				for encounterName, encounterTable in pairs(zTable) do 
					for _, item_id in pairs(encounterTable) do
						-- if not lootTableRev_Single[item_id] then 	-- insert only once
							-- lootTableRev_Single[item_id] = format("%s\1%s", zName, encounterName)
						-- end
						
						if not lootTableRev_Multi[item_id] then
							lootTableRev_Multi[item_id] = format("%s\1%s", zName, encounterName)
						else
							if lastZone[item_id] and lastZone[item_id] == zName then
								lootTableRev_Multi[item_id] = format("%s\1\1%s", lootTableRev_Multi[item_id], encounterName)
							else
								lootTableRev_Multi[item_id] = format("%s\1\1\1%s\1%s", lootTableRev_Multi[item_id], zName, encounterName)
							end
						end
						lastZone[item_id] = zName
					end
				end
			end
		end
		-- SECONDARY
		for _, zName in pairs(lootTable_names) do
			if lootSecondaryCheck[zName] then	-- check secondary sources next
				zTable = lootTable[zName]
				for encounterName, encounterTable in pairs(zTable) do 
					for _, item_id in pairs(encounterTable) do 
						-- if not lootTableRev_Single[item_id] then 	-- insert only once
							-- lootTableRev_Single[item_id] = format("%s\1%s", zName, encounterName)
						-- end
						
						if not lootTableRev_Multi[item_id] then
							lootTableRev_Multi[item_id] = format("%s\1%s", zName, encounterName)
						else
							if lastZone[item_id] and lastZone[item_id] == zName then
								lootTableRev_Multi[item_id] = format("%s\1\1%s", lootTableRev_Multi[item_id], encounterName)
							else
								lootTableRev_Multi[item_id] = format("%s\1\1\1%s\1%s", lootTableRev_Multi[item_id], zName, encounterName)
							end
						end
						lastZone[item_id] = zName
					end
				end
			end
		end
		
		-- LootSourceTooltip = { version = 0, single={}, multi={}, },
		wipe(LootSourceTooltipDB.db)
		-- wipe(LootSourceTooltipDB.single)
		LootSourceTooltipDB.db  = lootTableRev_Multi
		-- LootSourceTooltipDB.single = lootTableRev_Single
		
		LootSourceTooltipDB.version = LootSourceTooltip_VERSION
		
		wipe(lastZone)
		wipe(lootTable_names)
	else -- ################################################################################################
		
	end
	
	-- lootTable[ BZ["Vault of Archavon"] ] = nil 	-- we ignore this one, cuz its confusing
	wipe(lootTable)
end

function ns:GetSource(searchedID)
	DataProviders = DataProviders or {			-- list of sources that have a :GetSource() method
		DataStore_Reputations,
		DataStore_Crafts,
		DataStore_Inventory,
	}
	local txt, domain, subDomain
	
	-- if LootSourceTooltipDB.multi[searchedID] then
	if LootSourceTooltipDB.db[searchedID] then
		-- txt = LootSourceTooltipDB.multi[searchedID]
		txt = LootSourceTooltipDB.db[searchedID]
		
		local p = strfind(txt, "\1\1\1") 	-- check if multiple zones and take first
		if p then
			txt = strsub(txt, 1, p-1)
		end
		
		p = strfind(txt, "\1\1") 	-- check if multiple bosses and take first
		if p then
			txt = strsub(txt, 1, p-1)
		end
		domain, subDomain = strsplit("\1", txt) 	-- split zone from boss
		
		if domain and subDomain and domain~="" and subDomain~="" then
			return domain, subDomain
		end
	end
	

	-- local domain, subDomain
	for _, provider in pairs(DataProviders) do
		domain, subDomain = provider:GetSource(searchedID)
		if domain and subDomain then
			return domain, subDomain
		end
	end
	
	return nil
end

function ns:GetSource_multi(searchedID)
	-- if LootSourceTooltipDB.multi[searchedID] then
	if LootSourceTooltipDB.db[searchedID] then
		-- local txt = LootSourceTooltipDB.multi[searchedID]
		local txt = LootSourceTooltipDB.db[searchedID]
		txt = gsub(txt, "\1\1\1","; ") 
		txt = gsub(txt, "\1\1","/ ") 
		txt = gsub(txt, "\1",", ") 
		return txt
	end
end

function ns:GetSource_OLD(searchedID) 	-- old version
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
	-- print("-- DEBUG: CALLED ParseAltoholicLoots(OnMatch, OnNoMatch)")
	
	-- for itemID, txt in pairs(LootSourceTooltipDB.multi) do
	for itemID, txt in pairs(LootSourceTooltipDB.db) do
		if not listSearchedID[itemID] then	-- search only once
			listSearchedID[itemID] = 1
			
			count = count + 1
			filters:SetSearchedItem(itemID)
			
			if filters:ItemPassesFilters() then
				local p = strfind(txt, "\1\1\1") 	-- check if multiple zones and take first
				if p then
					txt = strsub(txt, 1, p-1)
				end
				
				p = strfind(txt, "\1\1") 	-- check if multiple bosses and take first
				if p then
					txt = strsub(txt, 1, p-1)
				end
				local Instance, Boss = strsplit("\1", txt) 	-- split zone from boss
				
				OnMatch(Instance, Boss)
			else
				if OnNoMatch then
					OnNoMatch()
				end
			end
			
		end
	end
	
	filters:ClearSearchedItem()
	return count
end

local function ParseAltoholicLoots_OLD(OnMatch, OnNoMatch)
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
					if not listSearchedID[itemID] then	-- search only once
						listSearchedID[itemID] = 1
						
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
	wipe(listSearchedID)
	
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
	-- print("-- DEBUG: CALLED ns:FindUpgradeByStats(currentID, class)")
	
	rawItemStats = {}
	currentItemStats = {}
	tooltipLines = {}
	
	AddCurrentlyEquippedItem(currentID, class)
	
	-- for itemID, txt in pairs(LootSourceTooltipDB.multi) do
	for itemID, txt in pairs(LootSourceTooltipDB.db) do
		
		local matches, itemLevel = MatchUpgradeByStats(itemID)
		
		if matches then
			local p = strfind(txt, "\1\1\1") 	-- check if multiple zones and take first
			if p then
				txt = strsub(txt, 1, p-1)
			end
			
			p = strfind(txt, "\1\1") 	-- check if multiple bosses and take first
			if p then
				txt = strsub(txt, 1, p-1)
			end
			local Instance, Boss = strsplit("\1", txt) 	-- split zone from boss
			
			if Instance and Boss then
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
	
	classExcludedStats = nil
	classBaseStats = nil
	currentItemStats = nil
	tooltipLines = nil
	rawItemStats = nil
end

function ns:FindUpgradeByStats_OLD(currentID, class)
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
