local _G, _ = _G, _
local table, tinsert, tremove, wipe, sort, date, time, random = table, table.insert, table.remove, wipe, sort, date, time, random
local math, tostring, string, strjoin, strlen, strlower, strsplit, strsub, strtrim, strupper, floor, tonumber = math, tostring, string, string.join, string.len, string.lower, string.split, string.sub, string.trim, string.upper, math.floor, tonumber
local select, pairs, print, next, type, unpack = select, pairs, print, next, type, unpack
local loadstring, assert, error = loadstring, assert, error
local kMiscellaneous = _G.kMiscellaneous

kMiscellaneous.defaults = {
	profile = {
		cvars = {
			matureLanguageFilterEnabled = false,
		},		
		debug = {
			enabled = false,
			enableTimers = true,
			threshold = 1,
		},
		grid = {
			autoPosition = {
				enabled = true,
				five = {
					x = '512',
					y = '-646',
				},
				solo = {
					x = '512',
					y = '-646',
				},
				ten = {
					x = '512',
					y = '-646',
				},
				twentyfive = {
					x = '307',
					y = '-374',
				},
			},
		},
	},
};
kMiscellaneous.timers = {}
kMiscellaneous.threading = {}
kMiscellaneous.threading.timers = {}
kMiscellaneous.threading.timerPool = {}
-- Create Options Table
kMiscellaneous.options = {
    name = "kMiscellaneous",
    handler = kMiscellaneous,
    type = 'group',
    args = {
		grid = {
			name = 'Grid',
			type = 'group',
			args = {
				autoPosition = {
					name = 'Auto-Position',
					type = 'group',
					args = {
						enabled = {
							name = 'Enable',
							type = 'toggle',
							desc = 'Toggle Grid auto-position.',
							set = function(info,value) 
								kMiscellaneous.db.profile.grid.autoPosition.enabled = value
								kMiscellaneous:Grid_Update()
							end,
							get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.enabled end,
						},
						solo = {
							name = 'Solo',
							type = 'group',
							args = {
								current = {
									type = 'execute',
									name = 'Copy from Grid',
									desc = 'Copy the settings from Grid and save in this configuration.',
									func = function() 
										kMiscellaneous:Grid_CopySettings('solo')
									end,
									order = 1,
									width = 'full',
								},
								x = {
									name = 'X coordinate',
									desc = 'Default x coordinate while solo.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.solo.x = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.solo.x end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the X coord of Grid.',
									order = 2,
								},
								y = {
									name = 'Y coordinate',
									desc = 'Default y coordinate while solo.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.solo.y = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.solo.y end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the Y coord of Grid.',
									order = 3,
								},
							},
						},
						five = {
							name = '5-man',
							type = 'group',
							args = {
								current = {
									type = 'execute',
									name = 'Copy from Grid',
									desc = 'Copy the settings from Grid and save in this configuration.',
									func = function() 
										kMiscellaneous:Grid_CopySettings('five')
									end,
									order = 1,
									width = 'full',
								},
								x = {
									name = 'X coordinate',
									desc = 'Default x coordinate for 5-man party size.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.five.x = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.five.x end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the X coord of Grid.',
									order = 1,
								},
								y = {
									name = 'Y coordinate',
									desc = 'Default y coordinate for 5-man party size.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.five.y = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.five.y end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the Y coord of Grid.',
									order = 2,
								},
							},
						},
						ten = {
							name = '10-man',
							type = 'group',
							args = {
								current = {
									type = 'execute',
									name = 'Copy from Grid',
									desc = 'Copy the settings from Grid and save in this configuration.',
									func = function() 
										kMiscellaneous:Grid_CopySettings('ten')
									end,
									order = 1,
									width = 'full',
								},
								x = {
									name = 'X coordinate',
									desc = 'Default x coordinate for 10-man raid size.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.ten.x = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.ten.x end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the X coord of Grid.',
									order = 1,
								},
								y = {
									name = 'Y coordinate',
									desc = 'Default y coordinate for 10-man raid size.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.ten.y = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.ten.y end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the Y coord of Grid.',
									order = 2,
								},
							},
						},
						twentyfive = {
							name = '25-man',
							type = 'group',
							args = {
								current = {
									type = 'execute',
									name = 'Copy from Grid',
									desc = 'Copy the settings from Grid and save in this configuration.',
									func = function() 
										kMiscellaneous:Grid_CopySettings('twentyfive')
									end,
									order = 1,
									width = 'full',
								},
								x = {
									name = 'X coordinate',
									desc = 'Default x coordinate for 25-man raid size.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.twentyfive.x = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.twentyfive.x end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the X coord of Grid.',
									order = 1,
								},
								y = {
									name = 'Y coordinate',
									desc = 'Default y coordinate for 25-man raid size.',
									type = 'input',
									set = function(info,value)
										kMiscellaneous.db.profile.grid.autoPosition.twentyfive.y = value
										kMiscellaneous:Grid_Update()
									end,
									get = function(info) return kMiscellaneous.db.profile.grid.autoPosition.twentyfive.y end,
									pattern = '^[+-]?%d+$',
									usage = 'Requires a valid integer for the Y coord of Grid.',
									order = 2,
								},
							},
						},
					},
				},
			},
		},
		debug = {
			name = 'Debug',
			type = 'group',
			args = {
				enabled = {
					name = 'Enabled',
					type = 'toggle',
					desc = 'Toggle Debug mode',
					set = function(info,value) kMiscellaneous.db.profile.debug.enabled = value end,
					get = function(info) return kMiscellaneous.db.profile.debug.enabled end,
				},
				enableTimers = {
					name = 'Enable Timers',
					type = 'toggle',
					desc = 'Toggle timer enabling',
					set = function(info,value) kMiscellaneous.db.profile.debug.enableTimers = value end,
					get = function(info) return kMiscellaneous.db.profile.debug.enableTimers end,
				},
				threshold = {
					name = 'Threshold',
					desc = 'Description for Debug Threshold',
					type = 'select',
					values = {
						[1] = 'Low',
						[2] = 'Normal',
						[3] = 'High',
					},
					style = 'dropdown',
					set = function(info,value) kMiscellaneous.db.profile.debug.threshold = value end,
					get = function(info) return kMiscellaneous.db.profile.debug.threshold end,
				},
			},
			cmdHidden = true,
		},
		cvars = {
			name = 'Cvars',
			type = 'group',
			args = {
				matureLanguageFilterEnabled = {
					name = 'Mature Language Filter',
					type = 'toggle',
					desc = 'Toggle Mature Language Filter.',
					set = function(info,value)
						kMiscellaneous.db.profile.cvars.matureLanguageFilterEnabled = value
						BNSetMatureLanguageFilter(kMiscellaneous.db.profile.cvars.matureLanguageFilterEnabled)
					end,
					get = function(info) return kMiscellaneous.db.profile.cvars.matureLanguageFilterEnabled end,
				},					
			},
		},		
        config = {
			type = 'execute',
			name = 'Config',
			desc = 'Open the Configuration Interface',
			func = function() 
				kMiscellaneous.dialog:Open("kMiscellaneous") 
			end,
			guiHidden = true,
        },
        version = {
			type = 'execute',
			name = 'Version',
			desc = 'Check your kMiscellaneous version',
			func = function() 
				kMiscellaneous:Print("Version: |cFF"..kMiscellaneous:Color_Get(0,255,0,nil,'hex')..kMiscellaneous.version.."|r");
			end,
			guiHidden = true,
        },
	},
};

--[[ Retrieve the selected key in the data table
]]
function kMiscellaneous:Options_GetSelected(data, selectionType)
	if not data or not type(data) == 'table' then return end
	selectionType = selectionType or 'key'
	for i,v in pairs(data) do
		if type(v) == 'table' then
			if v.selected and v.selected == true then
				if selectionType == 'key' then
					return i
				elseif selectionType == 'value' then
					return v
				elseif v[selectionType] then
					return v[selectionType]
				end
			end
		end
	end
end

--[[ Retrieve the value list for dropdown selection use from table/key
]]
function kMiscellaneous:Options_GetValueList(data, key)
	if not data or not key or not type(data) == 'table' then return end
	local output
	for i,v in pairs(data) do
		if v[key] then
			output = output or {}
			output[i] = v[key]
		end
	end
	return output
end

--[[ Resets the selected for the data table if necessary
]]
function kMiscellaneous:Options_ResetSelected(data)
	if not data or not type(data) == 'table' then return end
	local selectedCount = 0
	for i,v in pairs(data) do
		if type(v) == 'table' then
			if v.selected and v.selected == true then
				selectedCount = selectedCount + 1
			end
		end
	end
	-- If non-one value if selections then select first
	if selectedCount ~= 1 then
		self:Options_SetSelectedFirst(data)
	end
end

--[[ Properly edit specified table to ensure selected key is only selected option
]]
function kMiscellaneous:Options_SetSelected(data, key)
	if not data or not key or not type(data) == 'table' or not data[key] then return end
	for i,v in pairs(data) do
		v.selected = false
	end
	data[key].selected = true
end

--[[ Select the first key option in data table
]]
function kMiscellaneous:Options_SetSelectedFirst(data)
	if not data or not type(data) == 'table' then return end
	for i,v in pairs(data) do
		self:Options_SetSelected(data, i)
		break
	end
end