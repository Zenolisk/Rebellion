AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Grenade_Ent"
ENT.Author			= "Zenolisk"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable 		= true
ENT.Category 		= "Rebellion"

if SERVER then

	function ENT:Initialize()
		-- Boiler plate
		self.Entity:SetModel( "models/props_junk/garbage_plasticbottle001a.mdl" )
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		

		timer.Simple(3, function()
			if IsValid(self.Entity) then
				self:Destruct()
			end
		end)
		
	end

	function ENT:Use( activator, caller )		
	end
	
	function ENT:Destruct()
		self:EmitSound( "ambient/explosions/explode_" .. math.random( 1, 9 ) .. ".wav" )
		local d = DamageInfo()
		d:SetDamage( 35 )
		d:SetDamageType( DMG_CLUB )
		d:SetAttacker(self)
		
		util.BlastDamageInfo(d, self:GetPos(), 250)
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(0.1)
		util.Effect("Explosion", effectdata)
		for i=1,5 do
			local mini = ents.Create("reb_grenade_mini_ent")
			mini:SetPos(self:GetPos() + Vector(math.random(5,10),math.random(5,10),math.random(5,15)))
			mini:Spawn()
			local phys = mini:GetPhysicsObject()
			phys:ApplyForceCenter(Vector(math.random(-1000,1000),math.random(-1000,1000),math.random(1000,2000)))
		end
		
		self:Remove()
	end

	function ENT:PhysicsCollide(data, phys)

		if data.Speed > 50 then
			self.Entity:EmitSound( Format( "physics/metal/metal_grenade_impact_hard%s.wav", math.random( 1, 3 ) ) ) 
		end
		
		local impulse = -data.Speed * data.HitNormal * 0.1 + (data.OurOldVelocity * -0.1)
		phys:ApplyForceCenter(impulse)
	end

	
else

	--CL code

end