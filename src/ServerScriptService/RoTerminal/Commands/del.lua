local TerminalConfig = require(script.Parent.Parent:WaitForChild('TerminalConfig'))

return function(Args, Errors)
	local InsName = Args[2]
	local DeleteAllSameNames = string.lower(Args[3] or "") == "true"

	local Ins = TerminalConfig.CurDir:FindFirstChild(InsName)
	if not Ins then return Errors.InstanceNotFound, "Error" end

	if DeleteAllSameNames then
		for _, v in next, TerminalConfig.CurDir:GetChildren() do
			if v.Name == InsName then
				v:Destroy()
			end
		end
	else
		Ins:Destroy()
	end
	return "Instance/Instances have been destroyed", "Info"
end