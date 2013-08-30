local _G, _ = _G, _
local table, tinsert, tremove, wipe, sort, date, time, random = table, table.insert, table.remove, wipe, sort, date, time, random
local math, tostring, string, strjoin, strlen, strlower, strsplit, strsub, strtrim, strupper, floor, tonumber = math, tostring, string, string.join, string.len, string.lower, string.split, string.sub, string.trim, string.upper, math.floor, tonumber
local select, pairs, print, next, type, unpack = select, pairs, print, next, type, unpack
local loadstring, assert, error = loadstring, assert, error
local kMiscellaneous = _G.kMiscellaneous

--[[ Update Grid settings
]]
function kMiscellaneous:Grid_Update()
	if not self:Grid_IsLoaded() then return end
	if not self.db.profile.grid.autoPosition.enabled then return end
	local size = self:Grid_GetRaidSize()
	if not size or not self.db.profile.grid.autoPosition[size] then return end
	self:Grid_SetPosition(self.db.profile.grid.autoPosition[size].x, self.db.profile.grid.autoPosition[size].y)
end

--[[ Get the raid size as appropriate to the position settings
]]
function kMiscellaneous:Grid_GetRaidSize()
	local name, instanceType, difficultyID, difficultyName, maxPlayers = GetInstanceInfo()
	local instanceTypes = {
		'scenario',
		'party',
		'raid',
		'arena',
		'pvp',
	}
	local sizes = {
		solo = {
			min = 1,
			max = 1,
		},
		five = {
			min = 2,
			max = 5,
		},
		ten = {
			min = 6,
			max = 10,
		},
		twentyfive = {
			min = 11,
			max = 25,
		},
	}
	if not tContains(instanceTypes) then -- Assume none which is solo
		return 'solo'
	end
	-- Check maxplayers for matching sizes entry
	for size,entry in pairs(sizes) do
		for i,v in pairs(entry) do
			if (maxPlayers >= v.min) and (maxPlayers <= v.max) then
				-- Size match found, return
				return size
			end
		end
	end
	-- If no maxplayers entry found, check for current players within valid sizes
	local currentPlayers = self:Utility_GetPlayerCount()
	for size,entry in pairs(sizes) do
		for i,v in pairs(entry) do
			if (currentPlayers >= v.min) and (currentPlayers <= v.max) then
				-- Size match found, return
				return size
			end
		end
	end
end

--[[ Move Grid position
]]
function kMiscellaneous:Grid_SetPosition(x,y)
	if not self:Grid_IsLoaded() then return end
	Grid.modules.GridLayout.db.profile.PosX = x
	Grid.modules.GridLayout.db.profile.PosY = y
	Grid.modules.GridLayout:RestorePosition()
end

--[[ Check if Grid is loaded
]]
function kMiscellaneous:Grid_IsLoaded()
	if not IsAddOnLoaded('Grid') then return end
	if not Grid or not Grid.modules or not Grid.modules.GridLayout then return end
	return true
end