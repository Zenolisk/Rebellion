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

		local prop = ents.Create("reb_part")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:SetPos(pos + self:GetRight() * 23 + self:GetUp() * 10)
		prop:SetAngles(ang - Angle(0,0,0))
		prop:Spawn()
		prop:SetSkin(math.random(0,1))
		prop:SetParent(self)
	
		local prop = ents.Create("reb_part")
		prop:SetModel("models/props_c17/furnituredrawer001a_chunk01.mdl")
		prop:SetPos(pos + self:GetRight() * 23 + self:GetUp() * 21)
		prop:SetAngles(ang)
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/items/item_item_crate.mdl")
		prop:SetPos(pos + self:GetRight() * -25 + self:GetUp() * -9)
		prop:SetAngles(ang)
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/items/boxmrounds.mdl")
		prop:SetPos(pos + self:GetRight() * -28 + self:GetUp() * 15 + self:GetForward() * -5)
		prop:SetAngles(ang - Angle(0,30,0))
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/items/boxsrounds.mdl")
		prop:SetPos(pos + self:GetRight() * -15 + self:GetUp() * 15 + self:GetForward() * 7)
		prop:SetAngles(ang - Angle(0,98,0))
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/weapons/w_pistol.mdl")
		prop:SetPos(pos + self:GetRight() * -26 + self:GetUp() * 16 + self:GetForward() * 7)
		prop:SetAngles(ang - Angle(0,0,90))
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/items/boxbuckshot.mdl")
		prop:SetPos(pos + self:GetRight() * 35 + self:GetUp() * 31 + self:GetForward() * -2)
		prop:SetAngles(ang - Angle(0,-20,0))
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/items/boxbuckshot.mdl")
		prop:SetPos(pos + self:GetRight() * 15 + self:GetUp() * 31 + self:GetForward() * 4)
		prop:SetAngles(ang - Angle(0,30,0))
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_part")
		prop:SetModel("models/weapons/w_annabelle.mdl")
		prop:SetPos(pos + self:GetRight() * 18 + self:GetUp() * 29 + self:GetForward() * 16)
		prop:SetAngles(ang - Angle(0,90,90))
		prop:Spawn()
		prop:SetParent(self)
	
		self:DeleteOnRemove(prop)
	
	end
	
else

	function ENT:Draw()
		
	end
	
end
