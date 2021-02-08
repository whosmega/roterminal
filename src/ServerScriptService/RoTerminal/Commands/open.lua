local TerminalConfig = require(script.Parent.Parent:WaitForChild("TerminalConfig"))

return function(Args, Errors, plugin)
	local ScriptName = Args[2]
	local Script = TerminalConfig.CurDir:FindFirstChild(ScriptName)
	if Script then
		if Script:IsA("ModuleScript") or Script:IsA("Script") or Script:IsA("LocalScript") then
			plugin:OpenScript(Script)
		else
			return Errors["ScriptNotFound"], "Error"
		end
	else
		return Errors["ScriptNotFound"], "Error"
	end
end