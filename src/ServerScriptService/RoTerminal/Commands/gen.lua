local TerminalConfig = require(script.Parent.Parent:WaitForChild('TerminalConfig'))

return function(Args, Errors)
	local ClassName = Args[2]
	local Name = Args[3]

	if not ClassName then
		return Errors.ArgumentError, "Error"
	end
	local success, Check = pcall(function() return Instance.new(ClassName) end)
	if not success then return Errors.InvalidClass, "Error" end
	if Name then Check.Name = Name end

	Check.Parent = TerminalConfig.CurDir
end