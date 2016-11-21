reb.util = reb.util or {}

function reb.util.Include(name)
	if string.find(name, "sh_") then
		include(name)
		AddCSLuaFile(name)
	elseif string.find(name, "sv_") then
		if (SERVER) then
			include(name)
		end
	elseif string.find(name, "cl_") then
		if (SERVER) then
			AddCSLuaFile(name)
		else
			include(name)
		end
	end
end

function reb.util.IncludeDir(dir)

	for k, v in pairs(file.Find("rebellion/gamemode/"..dir.."/*.lua", "LUA")) do
	
		reb.util.Include(dir.."/"..v)
	
	end
	
end