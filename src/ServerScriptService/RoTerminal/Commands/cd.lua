local TerminalConfig = require(script.Parent.Parent:WaitForChild("TerminalConfig"))


return function(Args, Errors)
	local PathDetails = Args[2]
	local Child = TerminalConfig.CurDir:FindFirstChild(PathDetails)
	if Child then
		--// Switch path to the child
		TerminalConfig.CurDir = Child 
	elseif PathDetails == "game" then
		TerminalConfig.CurDir = game
	elseif PathDetails == ".." then
		--// Switch path to parent if applicable
		if TerminalConfig.CurDir.Parent ~= nil then
			TerminalConfig.CurDir = TerminalConfig.CurDir.Parent
		end
	elseif string.find(Args[2], "/") then
		local SplittedNodes = string.split(Args[2], "/")
		if SplittedNodes[1] == "game" then
			local CurrentInstance = game
			for i = 2, #SplittedNodes do
				if CurrentInstance:FindFirstChild(SplittedNodes[i]) then
					CurrentInstance = CurrentInstance[SplittedNodes[i]]
				else
					return Errors["PathError"], "Error"
				end
			end
			TerminalConfig.CurDir = CurrentInstance
		elseif TerminalConfig.CurDir:FindFirstChild(SplittedNodes[1]) then
			local CurrentInstance = TerminalConfig.CurDir:FindFirstChild(SplittedNodes[1])
			for i = 2, #SplittedNodes do
				if CurrentInstance:FindFirstChild(SplittedNodes[i]) then
					CurrentInstance = CurrentInstance[SplittedNodes[i]]
				else
					return Errors["PathError"], "Error"
				end
			end
			TerminalConfig.CurDir = CurrentInstance
		end
	else
		return Errors["PathError"], "Error"
	end
end