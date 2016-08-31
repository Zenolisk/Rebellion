reb.util = reb.util or {}

function reb.util.Include(name)
	if string.find(name, "sh_") then
		include(name)
		AddCSLuaFile(name)
		--print("SHARED: "..name)
	elseif string.find(name, "sv_") then
		if (SERVER) then
			include(name)
		end
		--print("SERVERSIDE: "..name)
	elseif string.find(name, "cl_") then
		if (SERVER) then
			AddCSLuaFile(name)
		else
			include(name)
		end
		--print("CLIENTSIDE: "..name)
	end
end

function reb.util.IncludeDir(dir)

	for k, v in pairs(file.Find("rebellion/gamemode/"..dir.."/*.lua", "LUA")) do
	
		reb.util.Include(dir.."/"..v)
	
	end
	
end
entity = entity or {}

function entity.create(ent, pos, model)
local entity = ents.Create( ent )
if ( !IsValid( entity ) ) then return end
if (model) then
entity:SetModel(model)
end
entity:SetPos( pos )
entity:Spawn()
end