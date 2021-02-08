--// Input / Output
local GUI, Mainframe, ListLayout, TemplateOutputLabel, TemplateInputBox = require(script.Parent:WaitForChild("UI"))()
local TerminalDefaults = require(script.Parent:WaitForChild("TerminalDefaults"))
local Translate = require(script.Parent:WaitForChild("Translate"))
local TerminalConfig = require(script.Parent:WaitForChild('TerminalConfig'))

local UIS = game:GetService("UserInputService")

local TranslateToPath = Translate.TranslateToPath
local TranslateToRblxType = Translate.TranslateToRblxType

local module = {}

function module.AddOutput(text, typ)
	local Template = TemplateOutputLabel:Clone()
	Template.Text = text
	Template.FontSize = Enum.FontSize.Size18
	Template.TextColor3 = TerminalConfig[typ.."Color"]

	Template.Parent = Mainframe
	if GUI.Parent == script.Parent then return end
	while not Template.TextFits do
		Template.Size += UDim2.fromOffset(0, TerminalDefaults.OutputLabelSize.Y.Offset)
	end
end


function module.GetInput(pathtype, header)
	local Template = TemplateInputBox:Clone()
	local PathText = pathtype and header..">" or TranslateToPath(TerminalConfig.CurDir) .. TerminalConfig.Prefix
	local Len = #PathText

	Template.Text = PathText --Get the translated string as path
	Template.FontSize = Enum.FontSize.Size18
	Template.TextColor3 = TerminalConfig.TextColor


	Template:GetPropertyChangedSignal("Text"):Connect(function()
		if #Template.Text < Len then
			Template.Text = PathText
			Template.CursorPosition = #PathText + 1
		end
	end)

	Template.Parent = Mainframe
	Template:CaptureFocus()
	local CanPass, Input
	local event = UIS.InputBegan:Connect(function(input, gpe)
		if input.KeyCode == Enum.KeyCode.Return then
			Input = string.sub(Template.Text, Len + 1)
			Template.TextEditable = false
			CanPass = true
		end
	end)

	while not CanPass do
		wait()
	end
	event:Disconnect()
	return Input
end

return module
