local TerminalConfig = require(script.Parent.Parent:WaitForChild('TerminalConfig'))
local Translate = require(script:WaitForChild("Translate"))
local TranslateToPath = Translate.TranslateToPath
local TranslateToRblxType = Translate.TranslateToRblxType

return function(Args, Errors)
	local Specifier = Args[2]
	local InstanceName = Args[3]
	local PropertyName = Args[4]
	local Value = Args[5]

	if string.lower(Specifier) == "-set" then
		if not (InstanceName or PropertyName or Value) then return Errors.ArgumentError, "Error" end
		local Ins = TerminalConfig.CurDir:FindFirstChild(InstanceName)
		if not Ins then return Errors.InstanceNotFound, "Error" end
		local success, AcceptedType = pcall(function() return typeof(Ins[PropertyName]) end)
		if not success then return Errors.InvalidProperty, "Error" end

		local TranslatedType, success = TranslateToRblxType(Value, AcceptedType)
		if not success then return Errors.InvalidProperty, "Error" end
		local success = pcall(function() Ins[PropertyName] = TranslatedType end)
		if not success then return Errors.InvalidProperty, "Error" end
	elseif string.lower(Specifier) == "-get" then
		if not (InstanceName or PropertyName) then return Errors.ArgumentError, "Error" end
		local Ins = TerminalConfig.CurDir:FindFirstChild(InstanceName)
		if not Ins then return Errors.InstanceNotFound, "Error" end
		local success, prop = pcall(function() return Ins[PropertyName] end)
		if not success then return Errors.InvalidProperty, "Error" end

		if typeof(prop) == "number" or typeof(prop) == "string" or typeof(prop) == "boolean" or typeof(prop) == "nil" then
			return tostring(prop), "Text"
		elseif typeof(prop) == "Color3" or typeof(prop) == "Vector3" then
			local typ = typeof(prop)
			local v1 = typ == "Vector3" and prop.X or (prop.R * 255)
			local v2 = typ == "Vector3" and prop.Y or (prop.G * 255)
			local v3 = typ == "Vector3" and prop.Z or (prop.B * 255)

			return string.format("%s : %s, %s, %s", typ, v1, v2, v3), "Text"
		elseif typeof(prop) == "EnumItem" then
			local Text = string.gsub(tostring(prop), "%.", "/")
			return "EnumItem : "..Text, "Text"
		end
	else
		return Errors.InvalidSpecifier, "Error"
	end		
end