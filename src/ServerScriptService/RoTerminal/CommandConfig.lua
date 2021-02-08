return {
	cd = {MinArgs = 1, MaxArgs = 1, Info = [=[
	Changes directory to given instance
	*ARGS* : 
	1. Name [Name of the instance or `..` if target is parent]]=]},
	config = {MinArgs = 2, MaxArgs = 2, Info = [=[
	Changes configuration of the terminal temporarily
	*ARGS*
	1. Name [Name of the property]:
		Hotkey [Toggle hotkey] [Accepts type `Character`]
		CurDir [Current directory] [Accepts type `Instance`]
		TextColor [Text Color of Terminal] [Accepts RGB as {R, G, B}]
		BackgroundColor [Background Color of Terminal] [Accepts RGB as {R, G, B}]
	2. Value [Value to be set accordingly]]=]},
	lua = {MinArgs = 0, MaxArgs = 0, Info = "Starts a lua terminal"},
	open = {MinArgs = 1, MaxArgs = 1, Info = [=[
	Opens a Script/LocalScript/ModuleScript in the Script Editor
	*ARGS*
	1. Name [Name of the script]]=]},
	tree = {MinArgs = 0, MaxArgs = 0, Info = "Displays a list of all descendants"},
	cmds = {MinArgs = 0, MaxArgs = 0, Info = "Displays all commands"},
	gen = {MinArgs = 2, MaxArgs = 2, Info = [=[
	Generates an instance in the current directory
	*ARGS*
	1. ClassName [Class Name of the instance]
	2. Name [Name to be set after creation] [OPTIONAL]]=]},
	del = {MinArgs = 1, MaxArgs = 1, Info = [=[
	Deletes an instance in the current directory
	*ARGS*
	1. Name [Name of the instance to be deleted]
	2. DeleteIfSameName [if true, deletes all instances in the current directory with the name provided] [OPTIONAL]]=]},
	prop = {MinArgs = 3, MaxArgs = 3, Info = [=[
	Performs a property operation on an instance (get/set)
	*ARGS*
	1. Action Specifier [
		`-set` : Sets a property to a value
		`-get` : Gets a property of a value
	]
	2. Name [Name of the instance]
	3. Property Name [Name of the property]
	4. Supported value [Only applicable when using `-set`] [Examples : 1, 0.5, blue, false, Enum/Material/Sand, Vector3 / Color3.fromRGB - {500, 500, 80}, Vector2 / UDim2(fromScale/fromOffset) - {0.5, 0.5}, UDim2 - {1, 100, 1, 100}]
	
	*NOTE* : Unexpected whitespaces in bracket formations will not work]=]},
	alias = {MinArgs = 2, MaxArgs = 2, Info = [=[
	Sets an alias name for an already valid command
	A command can have multiple aliases
	*ARGS*
	1. Action Specifier [
		`-set`: Sets an alias and saves it, which will let you use it next time
		`-tempset` : Sets an alias only for that session
		`-rem` : Removes an alias regardless of it being saved or temporary
		
	]
	2. Alias Name [Name of the alias to be set/removed]
	3. Command Name [Name of the command] [Only applicable if `-set/-tempset` is passed]
	
	
	*NOTE*
	You cannot set an alias name to a command name]=]}
}