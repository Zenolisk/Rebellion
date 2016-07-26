AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Author			= ""

ENT.AutomaticFrameAdvance = true

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.screen = "https://github.com/Zenolisk/Rebellion"
ENT.playerModel = "Default"

function ENT:KeyValue(key, value)
	if key == "screenURL" then
		if value != "url" then
			self.screen = tostring(value)
		end
	end
	
	if key == "PlayerModel" then
		self.playerModel = tostring(value)
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