local Toolbar = plugin:CreateToolbar("Ro Terminal v1")
local ToggleButton = Toolbar:CreateButton("Terminal", "Toggle the terminal", "")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

local Errors = require(script:WaitForChild("Errors"))
local TerminalDefaults = require(script:WaitForChild("TerminalDefaults"))
local IO = require(script:WaitForChild("IO"))
local Util = require(script:WaitForChild("Util")); Util.plugin = plugin

local Global = require(script:WaitForChild("Global"))
local TerminalConfig = require(script:WaitForChild("TerminalConfig"))
local ValidCommandConfig = require(script:WaitForChild("CommandConfig"))
local AliasCommandData = require(script:WaitForChild("AliasCommandData")) --This table stores aliases which are marked to be saved
local TempAliasCommandData = require(script:WaitForChild("TempAliasCommandData")) --All temporary aliases

local Commands = script:WaitForChild("Commands")

--// MAKE THE PLUGIN GUI
local GUI, Mainframe, ListLayout, TemplateOutputLabel, TemplateInputBox = require(script:WaitForChild('UI'))()
---------------------------------------		
Global.Showing = false
Global.SubTerminalEnabled = false
Global.VersionNumber = "1.1"

local AddOutput = IO.AddOutput
local GetInput = IO.GetInput

local CheckCommand = Util.CheckCommand
local GetArgs = Util.GetArgs
local ApplyLatestSettings = Util.ApplyLatestSettings

function ToggleTerminal()
	if not game:GetService("RunService"):IsEdit() then return end
	GUI.Parent = GUI.Parent == script and CoreGui or script
	Showing = GUI.Parent == CoreGui
end

function InputBegan(input, gpe)

	if input.KeyCode == TerminalConfig.Hotkey then
		if gpe then return end
		ToggleTerminal()
	end
end




function Process(input)
	--// First check if input is only a command, if thats the case then display API
	if ValidCommandConfig[input] and ValidCommandConfig[input].MinArgs ~= 0 then return ValidCommandConfig[input].Info, "Info" end
	local Args = GetArgs(input)
	if Errors[Args] then return Errors[Args], "Error" end

	--// Run Command
	for _, cmdname in next, Commands:GetChilren() do
		if cmdname == Args[1] then
			local Output, Type = require(cmdname)(Args, Errors, plugin) --Can return `nil/false` or `Output String and Output Type
			
			return Output, Type 
		end
	end
end

UIS.InputBegan:Connect(InputBegan)
ToggleButton.Click:Connect(ToggleTerminal)

Mainframe.ChildAdded:Connect(function(child)
	wait()
	local YOffset = child.Size.Y.Offset
	Mainframe.CanvasSize += UDim2.fromOffset(0, YOffset)
end)

if CoreGui:FindFirstChild("TerminalGui") then
	--// Clean up old mess
	CoreGui.TerminalGui:Destroy()
end

coroutine.wrap(function()
	while true do
		wait()
		if not game:GetService("RunService"):IsEdit() then
			if Showing then
				ToggleTerminal()
			end
		end
	end
end)()

ApplyLatestSettings()
AddOutput("RoTerminal Version "..Global.VersionNumber, "Info")
AddOutput("Programmed and Designed by the RoTerminal Open Source Community", "Info")
AddOutput("", "Text");

while true do
	local Input = GetInput()
	local Output, Type = Process(Input)

	if Output then
		AddOutput(Output, Type)
	end
	wait()
end