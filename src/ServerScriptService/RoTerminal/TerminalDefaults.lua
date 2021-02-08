return {
	Hotkey = Enum.KeyCode.Backquote, --[`]
	CurDir = workspace, 

	OutputFont = Enum.Font.Code,
	InputFont = Enum.Font.Code,

	OutputLabelSize = UDim2.new(1, 0, 0, 20),
	InputLabelSize = UDim2.new(1, 0, 0, 20),

	TextColor = Color3.fromRGB(255, 255, 255), --White
	ErrorColor = Color3.fromRGB(255, 0, 0), --Red
	WarnColor =  Color3.fromRGB(255, 170, 0), --Orangish
	InfoColor = Color3.fromRGB(85, 0, 255), --Blueish
	BackgroundColor = Color3.fromRGB(0, 0, 0), --Black

	Prefix = ">"
}