local TerminalConfig = require(script.Parent.Parent:WaitForChild("TerminalConfig"))
local IO = require(script.Parent.Parent:WaitForChild("IO"))
local ValidCommandConfig = require(script:WaitForChild("CommandConfig"))

local AliasCommandData = require(script:WaitForChild("AliasCommandData")) --This table stores aliases which are marked to be saved
local TempAliasCommandData = require(script:WaitForChild("TempAliasCommandData")) --All temporary aliases

local AddOutput = IO.AddOutput
local GetInput = IO.GetInput

return function(Args, Errors, plugin)
	local Option = Args[2]
	local AliasName = Args[3]
	local CommandName = Args[4]

	if not (Option and AliasName) then return Errors.ArgumentError, "Error" end
	if string.lower(Option) == "-set" then
		if not ValidCommandConfig[CommandName] then return Errors.InvalidCommandName, "Error" end --Command given is not a valid one
		if ValidCommandConfig[AliasName] then return Errors.CommandOverwriteAttempt, "Error" end --Alias name is that of a command
		if AliasCommandData[AliasName] or TempAliasCommandData[AliasName] then return Errors.AlreadyUtilizedAliasName, "Error" end --Alias is already in use
		if string.match(AliasName, "^[0-9]") then return Errors.InvalidAliasName, "Error" end --Alias name cannot start with numbers

		AliasCommandData[AliasName] = CommandName
		plugin:SetSetting("ALIASES", AliasCommandData)
		AddOutput(string.format("Alias name has been saved for %s as %s", CommandName, AliasName), "Info")
	elseif string.lower(Option) == "-tempset" then
		if not ValidCommandConfig[CommandName] then return Errors.InvalidCommandName, "Error" end --Command given is not a valid one
		if ValidCommandConfig[AliasName] then return Errors.CommandOverwriteAttempt, "Error" end --Alias name is that of a command
		if AliasCommandData[AliasName] or TempAliasCommandData[AliasName] then return Errors.AlreadyUtilizedAliasName, "Error" end --Alias is already in use
		if string.match(AliasName, "^[0-9]") then return Errors.InvalidAliasName, "Error" end --Alias name cannot start with numbers

		TempAliasCommandData[AliasName] = CommandName
		AddOutput(string.format("Alias name has been temporarily saved for %s as %s", CommandName, AliasName), "Info")
	elseif string.lower(Option) == "-rem" then
		if not AliasCommandData[AliasName] and not TempAliasCommandData[AliasName] then return Errors.AliasNameNotFound, "Error" end
		if AliasCommandData[AliasName] then
			AliasCommandData[AliasName] = nil
			plugin:SetSetting("ALIASES", AliasCommandData)
		else
			TempAliasCommandData[AliasName] = nil
		end
		AddOutput("Alias name has been removed", "Info")
	else
		return Errors.InvalidSpecifier, "Error"
	end
end