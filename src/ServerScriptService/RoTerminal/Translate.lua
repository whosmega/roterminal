local module = {}

function module.TranslateToRblxType(value, acceptedvaluetype)
	local Selected
	--// Check Number datatype
	if tonumber(value) then 
		Selected = tonumber(value) 
		--// Check for enum datatypes
	elseif string.match(value, "^nil$") then
		Selected = nil
	elseif string.match(value, "Enum/") then
		local Splitted = string.split(value, "/")
		local success, enumeration = pcall(function() return Enum[Splitted[2]][Splitted[3]] end)
		if not success then return _, false end

		Selected = enumeration
		--// Check for Vector3 / Color3.fromRGB / Vector2 / UDim2
	elseif string.find(value, "{") and string.find(value, "}") and (acceptedvaluetype == "Vector3" or acceptedvaluetype == "Color3" or acceptedvaluetype == "Vector2" or acceptedvaluetype == "UDim2") then
		local Numbers = string.split(string.gsub(value, "[{}%s]", ""), ",")
		if #Numbers > 4 then return "", false end
		for _, v in next, Numbers do
			if not tonumber(v) then return "", v end
		end

		if #Numbers == 1 then return "", false end
		if #Numbers == 2 then
			Selected = Vector2.new(unpack(Numbers))
		elseif #Numbers == 3 then
			Selected = acceptedvaluetype == "Vector3" and Vector3.new(unpack(Numbers)) or Color3.fromRGB(unpack(Numbers))
		elseif #Numbers == 4 then
			Selected = UDim2.new(unpack(Numbers))
		end
		--// Boolean
	elseif value == "true" or value == "false" then
		if value == "true" then
			Selected = true
		else
			Selected = false
		end
	else
		--// String
		Selected = value
	end
	if typeof(Selected) == acceptedvaluetype or typeof(Selected) == nil then return Selected, true end
	return "", false
end

function module.TranslateToPath(instance)
	local path = ""
	local function AddToPath(ins)
		path = string.format("%s/%s", ins.Name, path)
		if ins.Parent ~= nil then
			AddToPath(ins.Parent)
		end
	end
	AddToPath(instance)
	path = string.gsub(path, game.Name, "game") --Replace the game's actual name to `game`
	return path
end


return module
