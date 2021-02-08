local TerminalConfig = require(script.Parent.Parent:WaitForChild('TerminalConfig'))
local ValidCommandConfig = require(script:WaitForChild("CommandConfig"))
local IO = require(script.Parent.Parent:WaitForChild("IO"))

local AddOutput = IO.AddOutput
local GetInput = IO.GetInput

return function(Args, Errors)
	for cmdname, data in next, ValidCommandConfig do
		AddOutput(cmdname, "Text")
		AddOutput(data.Info, "Info")
	end
end