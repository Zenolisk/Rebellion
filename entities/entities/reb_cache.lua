AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Weapon Cache"
ENT.Author			= "Zenolisk"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable 		= true

if SERVER then

	function ENT:Initialize()
		self.Entity:SetModel( "models/hunter/blocks/cube1x2x05.mdl" )
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_NONE)
		self.Entity:SetSolid(SOLID_VPHYSICS)

		self:SpawnDetail()

	end
	
	function ENT:SpawnDetail()
	
		local pos = self:GetPos()
		local ang = self:GetAngles()

		local prop = ents.Create("reb_part")
		prop:SetModel("models/props_c17/furnitureshelf001a.mdl")
		prop:SetPos(pos - Vector(0,0,2))
		prop:SetAngles(ang + Angle(-90,90,0))
		prop:Spawn()
		prop:SetSkin(math.random(0,2))
		prop:SetParent(self)
	
		self:DeleteOnRemove(prop)
	
	end
	
else

	function ENT:Draw()
		
	end
	
end
