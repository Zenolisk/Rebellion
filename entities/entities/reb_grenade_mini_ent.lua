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
		self.Entity:SetModel( "models/Items/AR2_Grenade.mdl" )
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		
	end

	function ENT:Use( activator, caller )		
	end
	
	function ENT:Destruct()
		--self:EmitSound( "ambient/explosions/explode_" .. math.random( 1, 9 ) .. ".wav" )
		local d = DamageInfo()
		d:SetDamage( 40 )
		d:SetDamageType( DMG_CLUB )
		d:SetAttacker(self)
		
		util.BlastDamageInfo(d, self:GetPos(), 175)
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(0.1)
		util.Effect("Explosion", effectdata)
		self:Remove()
	end

	function ENT:PhysicsCollide(data, phys)
		self:Destruct()
	end

	
else

	--CL code

end