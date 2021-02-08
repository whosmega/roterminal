--// This module makes the plugin UI
local TerminalDefaults = require(script.Parent:WaitForChild('TerminalDefaults'))

return function()
	local GUI = Instance.new("ScreenGui")
	GUI.Name = "TerminalGui"
	GUI.ResetOnSpawn = false
	GUI.DisplayOrder = 10
	GUI.IgnoreGuiInset = true
	GUI.Parent = script.Parent

	local Mainframe = Instance.new("ScrollingFrame")
	Mainframe.Name = "Main"
	Mainframe.Size = UDim2.new(1, 0, 1, 0)
	Mainframe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Mainframe.AnchorPoint = Vector2.new(0.5, 0.5)
	Mainframe.Position = UDim2.new(0.5, 0, 0.5, 0)
	Mainframe.Parent = GUI
	Mainframe.BorderSizePixel = 0
	Mainframe.ScrollBarThickness = 4

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.Parent = Mainframe
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local TemplateOutputLabel = Instance.new("TextLabel")
	TemplateOutputLabel.BackgroundTransparency = 1
	TemplateOutputLabel.Font = TerminalDefaults.OutputFont
	TemplateOutputLabel.Size = TerminalDefaults.OutputLabelSize
	TemplateOutputLabel.TextWrapped = true
	TemplateOutputLabel.TextXAlignment = Enum.TextXAlignment.Left


	local TemplateInputBox = Instance.new("TextBox")
	TemplateInputBox.BackgroundTransparency = 1
	TemplateInputBox.Font = TerminalDefaults.InputFont
	TemplateInputBox.Size = TerminalDefaults.InputLabelSize
	TemplateInputBox.TextWrapped = true
	TemplateInputBox.ClearTextOnFocus = false
	TemplateInputBox.TextXAlignment = Enum.TextXAlignment.Left
	
	return GUI, Mainframe, ListLayout, TemplateOutputLabel, TemplateInputBox
end