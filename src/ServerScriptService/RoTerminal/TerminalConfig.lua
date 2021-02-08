local TerminalDefaults = require(script.Parent:WaitForChild("TerminalDefaults"))
return {
	Hotkey = TerminalDefaults.Hotkey,
	CurDir = TerminalDefaults.CurDir,

	TextColor = TerminalDefaults.TextColor,
	BackgroundColor = TerminalDefaults.BackgroundColor,
	ErrorColor = TerminalDefaults.ErrorColor,
	WarnColor = TerminalDefaults.WarnColor,
	InfoColor = TerminalDefaults.InfoColor,
	Prefix = TerminalDefaults.Prefix
}