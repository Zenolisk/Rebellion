AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Author			= ""

ENT.AutomaticFrameAdvance = true

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.status = 0

function ENT:KeyValue(key, value)

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