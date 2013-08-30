local _G, _ = _G, _
local table, tinsert, tremove, wipe, sort, date, time, random = table, table.insert, table.remove, wipe, sort, date, time, random
local math, tostring, string, strjoin, strlen, strlower, strsplit, strsub, strtrim, strupper, floor, tonumber = math, tostring, string, string.join, string.len, string.lower, string.split, string.sub, string.trim, string.upper, math.floor, tonumber
local select, pairs, print, next, type, unpack = select, pairs, print, next, type, unpack
local loadstring, assert, error = loadstring, assert, error
local kMiscellaneous = _G.kMiscellaneous

function kMiscellaneous:PLAYER_ENTERING_WORLD()
	RegisterAddonMessagePrefix("kMiscellaneous")
end

function kMiscellaneous:Event_OnRaidInstanceWelcome()
	self:Debug('Event_OnRaidInstanceWelcome', GetRealZoneText(), 1)
	-- Update Grid
	self:Grid_Update()
end

function kMiscellaneous:Event_OnZoneChanged()
	self:Debug('Event_OnZoneChanged', GetRealZoneText(), 1)
	-- Update Grid
	self:Grid_Update()
end