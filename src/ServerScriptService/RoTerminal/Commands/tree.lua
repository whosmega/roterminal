local TerminalConfig = require(script.Parent.Parent:WaitForChild("TerminalConfig"))

return function(Args, Errors)
	local Output = ""
	local NumDescendants = #TerminalConfig.CurDir:GetDescendants()
	local Indent = " "
	local Formatting = "-"
	local NodeLayer = 0 --0 is the highest (no spaces)

	if NumDescendants == 0 then return Errors["NoDescendants"], "Error" end

	local function List(instance)
		Output ..= (NodeLayer == 0 and "" or "\n").. string.rep(Indent, NodeLayer) .. Formatting ..instance.Name

		if #instance:GetChildren() > 0 then

			NodeLayer += 1
			for _, child in next, instance:GetChildren() do
				local Current = NodeLayer
				List(child)
				NodeLayer = Current
			end

		end
	end
	List(TerminalConfig.CurDir)
	return Output, "Warn"
end