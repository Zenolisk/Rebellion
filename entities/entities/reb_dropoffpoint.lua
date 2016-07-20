AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Author			= "Oskar"
ENT.AdminSpawnable		= true

if (SERVER) then

	function ENT:Initialize()
		self:SetModel( "models/props_wasteland/cargo_container01b.mdl" )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		
		self:SpawnDetail()
	end
	
	function ENT:SpawnDetail()
		local pos = self:GetPos()
		local ang = self:GetAngles()
		
		local prop = ents.Create("reb_physicalpart")
		prop:SetModel("models/props_wasteland/controlroom_desk001b.mdl")
		prop:SetPos(pos - Vector(-40, -70, 33))
		prop:SetAngles(ang + Angle(0, 180, 0))
		prop:Spawn()
		prop:SetParent(self)
		
		local prop = ents.Create("reb_physicalpart")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:SetPos(pos - Vector(-30, -160, 30))
		prop:SetAngles(ang + Angle(0, 30, 0))
		prop:Spawn()
		prop:SetParent(self)

		local prop = ents.Create("reb_physicalpart")
		prop:SetModel("models/props_interiors/refrigerator01a.mdl")
		prop:SetPos(pos - Vector(40, -170, 13))
		prop:SetAngles(ang + Angle(0, -50, 0))
		prop:Spawn()
		prop:SetParent(self)

		local prop = ents.Create("reb_physicalpart")
		prop:SetModel("models/props_wasteland/kitchen_shelf001a.mdl")
		prop:SetPos(pos - Vector(-45, 20, 50))
		prop:SetAngles(ang + Angle(0, 90, 0))
		prop:Spawn()
		prop:SetParent(self)
	end
	
	function ENT:Think()
	local pos = self:GetPos()
		for k, v in pairs(ents.FindInBox( Vector(pos.x -50, pos.y- 100, pos.z -50), Vector(pos.x + 50, pos.y+ 180, pos.z + 50) )) do
			if v:GetClass() == "reb_crate" then
				local res = v:GetResource()
				local amt = v:GetResourceAmount()
				addResources(res, amt)
				self:UpdateDecor()
				v:GetHolder():PrintMessage(HUD_PRINTCENTER, "You have delivered "..amt.." amount of "..res.." to your storage.")
				self:EmitSound("buttons/button4.wav")
				v:Remove()
			end
		end
	
	end
	
	function ENT:UpdateDecor()
	local food = resources.food
	local weap = resources.weap
	local scrap = resources.scrap
	
	
	end
	
	
else
	
end


