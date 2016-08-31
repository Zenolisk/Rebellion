AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Author			= ""
ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.uniqueID = ""
ENT.model = ""
ENT.amount = 0

function ENT:Initialize()

	self:SetModel( self.model )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

end

function ENT:Use(client)

	client:giveItem(self.uniqueID, self.amount)
	client:EmitSound("reb/items_pickup"..math.random(1,6)..".wav")
	self:Remove()

end