local module = {}
local ValidCommandConfig = require(script.Parent:WaitForChild("CommandConfig"))
local TempAliasCommandData = require(script.Parent:WaitForChild("TempAliasCommandData"))
local AliasCommandData = require(script.Parent:WaitForChild("AliasCommandData"))

function module.ApplyLatestSettings()
	--// ALIASES
	local SavedAliasTable = module.plugin:GetSetting("ALIASES")
	if SavedAliasTable then module.savetable(AliasCommandData, SavedAliasTable) end

end

function module.savetable(old, new)
	--// Overwrites the table 
	for k, v in next, new do
		old[k] = v
	end
end

function module.IsAlias(command)
	for aliasname, data in next, AliasCommandData do
		if aliasname == command then return data end
	end
	for aliasname, data in next, TempAliasCommandData do
		if aliasname == command then return data end
	end
	return false
end

function module.CheckCommand(got, expected)
	if string.lower(got) == expected then return true end
	local command = module.IsAlias(string.lower(got))
	if command and command == expected then return true end
	return false
end

function module.GetArgs(input)
	local Stuff = string.split(input, " ")
	if not (ValidCommandConfig[Stuff[1]] or module.IsAlias(Stuff[1])) then return "InvalidCommand" end 
	return Stuff
end


return module
