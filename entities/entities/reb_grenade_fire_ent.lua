AddCSLuaFile()

ENT.Type 		= "anim"
ENT.Base 		= "base_anim"

ENT.PrintName	= "Molotov"
ENT.Author		= "Zenolisk"
ENT.Contact		= ""

if (SERVER) then

	function ENT:Initialize()
		self.Entity:SetModel("models/props_junk/garbage_glassbottle003a.mdl")
		
		self.Entity:PhysicsInit( SOLID_VPHYSICS )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )

		local phys = self.Entity:GetPhysicsObject()
		
		if (phys:IsValid()) then
			phys:Wake()
		end
		
		
		local zfire = ents.Create( "env_fire_trail" )
			zfire:SetPos( self.Entity:GetPos() )
			zfire:SetParent( self.Entity )
			zfire:Spawn()
			zfire:Activate()
		
	end

	function ENT:Think() 
	end

	function ENT:Explosion()
		--util.BlastDamage( self.Entity, self.Entity:GetOwner(), self.Entity:GetPos(), 20, 10 )
		/*
		local explo = ents.Create( "env_explosion" )
			explo:SetOwner( self.Owner )
			explo:SetPos( self.Entity:GetPos() )
			explo:SetKeyValue( "iMagnitude", "50" )
			explo:SetKeyValue( "iRadiusOverride", "400" )
			explo:Spawn()
			explo:Activate()
			explo:Fire( "Explode", "", 0 )
		*/
		
		for i=1, 3 do
			local fire = ents.Create( "env_fire" )
				fire:SetPos( self.Entity:GetPos() + Vector( math.random( -60, 90 ), math.random( -60, 90 ), 0 ) )
				fire:SetKeyValue( "health", math.random( 15, 25 ) )
				fire:SetKeyValue( "firesize", "32" )
				fire:SetKeyValue( "fireattack", "4" )
				fire:SetKeyValue( "damagescale", "2.0" )
				fire:SetKeyValue( "StartDisabled", "0" )
				fire:SetKeyValue( "firetype", "0" )
				fire:SetKeyValue( "spawnflags", "132" )
				fire:Spawn()
				fire:Fire( "StartFire", "", 0.2 )
		end
		
		for i=1, 3 do
			local fire1 = ents.Create( "env_fire" )
				fire1:SetPos( self.Entity:GetPos() + Vector( math.random( -100, 160 ), math.random( -100, 160 ), 0 ) )
				fire1:SetKeyValue( "health", math.random( 15, 25 ) )
				fire1:SetKeyValue( "firesize", "16" )
				fire1:SetKeyValue( "fireattack", "4" )
				fire1:SetKeyValue( "damagescale", "2.0" )
				fire1:SetKeyValue( "StartDisabled", "0" )
				fire1:SetKeyValue( "firetype", "0" )
				fire1:SetKeyValue( "spawnflags", "132" )
				fire1:Spawn()
				fire1:Fire( "StartFire", "", 0.6 )
		end
		
		for i=1, 3 do
			local fire2 = ents.Create( "env_fire" )
				fire2:SetPos( self.Entity:GetPos() + Vector( math.random( -120, 180 ), math.random( -120, 180 ), 0 ) )
				fire2:SetKeyValue( "health", math.random( 15, 20 ) )
				fire2:SetKeyValue( "firesize", "8" )
				fire2:SetKeyValue( "fireattack", "4" )
				fire2:SetKeyValue( "damagescale", "2.0" )
				fire2:SetKeyValue( "StartDisabled", "0" )
				fire2:SetKeyValue( "firetype", "0" )
				fire2:SetKeyValue( "spawnflags", "132" )
				fire2:Spawn()
				fire2:Fire( "StartFire", "", 1 )
		end
				
		for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 200 ) ) do
			if v:IsValid() and v:IsPlayer() or v:IsNPC() then
			v:Ignite( 3, 1 )
			end
		end
	end


	function ENT:PhysicsCollide( data, physobj ) 
		util.Decal("Scorch", data.HitPos + data.HitNormal , data.HitPos - data.HitNormal) 
		self.Entity:EmitSound("physics/glass/glass_sheet_break"..math.random(1,3)..".wav")
		self:Explosion()
		self.Entity:Remove()
	end

else

	function ENT:Think()
		
		-- ######################## Dynamic light

			local dynlight = DynamicLight(0);
			dynlight.Pos = self:GetPos();
			dynlight.Size = math.random(150,385);
			dynlight.R = math.random(240,255);
			dynlight.G = math.random(210,225);
			dynlight.B = 55;
			dynlight.Brightness = 1
			dynlight.Decay = 3000
			dynlight.DieTime = CurTime() + 1
			dynlight.Style = 1
			
	end

end
