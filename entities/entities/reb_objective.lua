AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Author			= ""

ENT.AutomaticFrameAdvance = true

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.desc = ""
ENT.index = 0
ENT.status = 0
ENT.hidden = false

function ENT:KeyValue(key, value)
	if key == "description" then
		self.desc = tostring(value)
	end
	
	if key == "index" then
		self.index = tonumber(value)
	end
	
	if key == "hidden" then
		self.hidden = tobool(value)
		print(value)
	end
end

if SERVER then

	function ENT:Initialize()
		self:SetSolid(SOLID_NONE)
		self:DrawShadow(false)
		self:SetMoveType(MOVETYPE_NONE)
	end

else
		
	function ENT:Draw()
	end
	
end