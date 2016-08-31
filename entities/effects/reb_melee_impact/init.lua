function EFFECT:Init( data )
	
	local posoffset = data:GetOrigin()

	local emitter = ParticleEmitter( posoffset )

		for i = 0,5 do
			local p = emitter:Add( "particle/particle_smokegrenade", posoffset )

			p:SetVelocity( math.random(6,12) * math.sqrt(i) * data:GetNormal() * 3 + 2 * VectorRand() )
			p:SetAirResistance(400)

			p:SetStartAlpha( math.Rand( 255, 255 ) )
			p:SetEndAlpha( 0 )
			p:SetDieTime( math.Rand( 0.5, 1.5 ) )

			p:SetStartSize( math.Rand( 15, 25 ) *math.Clamp(i,1,4) * 0.166 )
			p:SetEndSize( math.Rand( 32, 42 ) * math.sqrt(math.Clamp(i,1,4)) * 0.166 )

			p:SetRoll( math.Rand( -25, 25 ) )
			p:SetRollDelta( math.Rand( -0.05, 0.05 ) )

			p:SetColor( 135, 135, 135 )
		end
		
	emitter:Finish()
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
	return false
end