local IO = require(script.Parent.Parent:WaitForChild("IO"))
local AddOutput = IO.AddOutput
local GetInput = IO.GetInput
local Global = require(script.Parent.Parent:WaitForChild("Global"))

local LogService = game:GetService("LogService")

return function(Args, Errors)
	--// Start sub terminal loadstring input and post output

	AddOutput("Started lua terminal", "Info")
	AddOutput("Binded To Console Output", "Info")
	AddOutput("Type `exit` to exit lua terminal", "Text")

	Global.SubTerminalEnabled = true
	local event = LogService.MessageOut:Connect(function(message, typ)
		message = "    " .. message
		message = string.gsub(message, "\n", "\n    ")

		if typ == Enum.MessageType.MessageError then
			AddOutput(message, "Error")
		elseif typ == Enum.MessageType.MessageWarning then
			AddOutput(message, "Warn")
		elseif typ == Enum.MessageType.MessageOutput then
			AddOutput(message, "Text")
		end
	end)

	while true do
		wait()
		local input = GetInput("SubTerminal", "    Lua")

		if string.lower(input) == "exit" then 
			AddOutput("Exited lua terminal", "Info")
			AddOutput("Unbinded From Console Output", "Info")
			event:Disconnect()
			Global.SubTerminalEnabled = false
			return
		end

		local success, output = pcall(function() local f = loadstring(input) return f() end)

		if not success then
			--// An error occured
			local output = string.gsub(output, string.format("loadstring(%s)()", input), "")
			AddOutput(output, "Error")
		end
	end
end