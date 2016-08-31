AddCSLuaFile()

if CLIENT then
	
	SWEP.PrintName = "Grenade"
	SWEP.Slot = 5
	SWEP.Slotpos = 1
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 54
	
	SWEP.IconLetter = "Q"

end

SWEP.Spawnable = true
SWEP.HoldType = "grenade"

SWEP.UseHands = true
SWEP.Category			= "TechWars"

SWEP.ViewModel			= "models/weapons/c_grenade.mdl"
SWEP.WorldModel			= "models/weapons/w_grenade.mdl"

SWEP.Primary.ThrowForce			= 1000
SWEP.Primary.ClipSize		= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.ThrowSound          = Sound( "npc/turret_floor/click1.wav" )
SWEP.Primary.ThrowTaunt         = Sound( "npc/turret_floor/click1.wav" )

function SWEP:PrimaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 3)
	self.Weapon:EmitSound(""..table.Random(grenadesounds).."")
	self:Grenade(self.Primary.ThrowForce)
	
end

function SWEP:SecondaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 3)
	self.Weapon:EmitSound(""..table.Random(grenadesounds).."")
	self:Grenade(self.Primary.ThrowForce/2)
	
end

function SWEP:Grenade(force)
	if (SERVER) then
		local ent = ents.Create( "tw_grenade_com_exp" )
		
		if ( !IsValid( ent ) ) then return end
		
		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 24 ) )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent.team = self.Owner:Team()
		ent:Spawn()
		
		local phys = ent:GetPhysicsObject()
	
		if ( !IsValid( phys ) ) then ent:Remove() return end
		
		local velocity = self.Owner:GetAimVector()
		velocity = velocity * force + self.Owner:GetVelocity() * 2
		velocity = velocity + ( VectorRand() * 30 ) -- a random element
		if self.Owner:IsOnGround() then
		velocity = velocity
		else
		velocity = velocity + (Vector(0,0,100))
		end
		phys:ApplyForceCenter( velocity )
		phys:AddAngleVelocity( self.Owner:GetAimVector() * 500 )
		
		self.Owner:StripWeapon( "tfa_com_grenade_exp" )
	end
end

function SWEP:Reload()
	return
end