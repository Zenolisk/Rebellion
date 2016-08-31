AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Melee Base"
	SWEP.Slot = 1
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Zenolisk"
SWEP.Instructions = "Primary Fire: [RAISED] Strike"
SWEP.Purpose = "Hitting things."
SWEP.Drop = false

SWEP.HoldType = "melee"

SWEP.Category			= "Rebellion"
SWEP.ViewModelFOV = 47
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.7

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.WorldModel = Model("models/props_canal/mattpipe.mdl")

SWEP.UseHands = true
SWEP.originMod = Vector(0, 0, 0)
SWEP.weaponLength = 8

local swayLimit = 11
function SWEP:Precache()
	util.PrecacheSound("weapons/crowbar/crowbar_impact1.wav")
	util.PrecacheSound("weapons/crowbar/crowbar_impact2.wav")
	util.PrecacheSound("npc/vort/claw_swing1.wav")
	util.PrecacheSound("npc/vort/claw_swing2.wav")
	util.PrecacheSound("npc/zombie/claw_strike1.wav")
	util.PrecacheSound("npc/zombie/claw_strike2.wav")
	util.PrecacheSound("npc/zombie/claw_strike3.wav")
	util.PrecacheSound("npc/vort/foot_hit.wav")
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

local cureffect = ""

function SWEP:PrimaryAttack()	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:ViewPunch(Angle(1, 0, 0.125))

	self.Owner:LagCompensation(true)
		local data = {}
			data.start = self.Owner:GetShootPos()
			data.endpos = data.start + self.Owner:GetAimVector()*72
			data.filter = self.Owner
		local trace = util.TraceLine(data)
	self.Owner:LagCompensation(false)
	
	if (SERVER and trace.Hit) then
	
		if trace.MatType == MAT_METAL then
			self.Owner:EmitSound("weapons/crowbar/crowbar_impact"..math.random(1,2)..".wav", 75, math.random(90,110))
			cureffect = "MetalSpark"
		elseif trace.MatType == (MAT_FLESH) then
			self.Owner:EmitSound("npc/zombie/claw_strike"..math.random(1, 3)..".wav", 75, math.random(90,110))
			cureffect = "BloodImpact"
		else
			self.Owner:EmitSound("npc/vort/foot_hit.wav", 75, math.random(90,110))
			cureffect = "reb_melee_impact"
		end
	
		local entity = trace.Entity

			local effect = EffectData()
		effect:SetStart(trace.HitPos)
		effect:SetNormal(trace.HitNormal)
		effect:SetOrigin(trace.HitPos)
		util.Effect( cureffect, effect, true, true )
		
		if (IsValid(entity)) then
			if (entity:IsPlayer()) then
				entity:ScreenFadeOut(1, Color(128, 0, 0, 200))
				entity:ViewPunch(Angle(-20, math.random(-15, 15), math.random(-10, 10)))
				if (entity:Health() - self.Primary.Damage <= 0) then
					entity:SetTimedRagdoll(60, true)
					entity:SetHealth(30)

					return
				end
			end
			
			local damageInfo = DamageInfo()
				damageInfo:SetAttacker(self.Owner)
				damageInfo:SetInflictor(self)
				damageInfo:SetDamage(self.Primary.Damage)
				damageInfo:SetDamageType(DMG_CLUB)
				damageInfo:SetDamagePosition(trace.HitPos)
				damageInfo:SetDamageForce(self.Owner:GetAimVector()*10000)
			entity:DispatchTraceAttack(damageInfo, data.start, data.endpos)
		end
	end
end

if CLIENT then

	local posOutput = Vector(0, 0, 0)
	local posTarget = Vector(0, 0, 0)
	local angOutput = Angle(0, 0, 0)
	local angTarget = Angle(0, 0, 0)
	local oldAimVec = Vector(0 ,0, 0)
	local viewMoveMul = .01
	local curStep = 0
	local sin, cos = math.sin, math.cos
	local clamp = math.Clamp
	local bobPos = Vector()
	local swayPos = Vector()
	local lateBobPos = Vector()
	local restPos = Vector()
	local bobAng = Angle()
	SWEP.aimAngle = Angle()
	SWEP.oldAimAngle = Angle()
	SWEP.aimDiff = Angle()
	SWEP.ironMul = 1
	local LT = CurTime()

	local function int(delta, from, to)
		local intType = type(from)

		if intType == "Angle" then
			from = util_NormalizeAngles(from)
			to = util_NormalizeAngles(to)
		end

		local out = from + (to-from)*delta

		return out
	end
	
	function SWEP:GetViewModelPosition( pos, ang )
		local owner = self.Owner
		local EP, EA, FT, CT, DIFF = EyePos(), EyeAngles(), FrameTime(), CurTime(), LT - CurTime()
		LT = CurTime()
		local PA = owner:GetViewPunchAngles()
		local vel = clamp(owner:GetVelocity():Length2D()/reb.config.walkSpeed, 0, 1.5)
		local rest = 1 - clamp(owner:GetVelocity():Length2D()/20, 0, 1)
		local DIFFB = ((1 - DIFF)*.05)

		posOutput = Vector(0, 0, 0)
		curStep = CT * ((vel < .5) and 5 or 15)

		self.ironMul = int(.1, self.ironMul, (!self.Owner:OnGround()) and (!self.Owner:OnGround() and 0 or .1) or 1)

		bobPos[1] = -sin(curStep/2)*vel
		bobPos[2] = sin(curStep/4)*vel*1.5
		bobPos[3] = sin(curStep)/1.5*vel - clamp(vel, 0, 1)*5
		restPos[3] = sin(CT*2)*4
		restPos[1] = cos(CT*1)*3

		swayPos[1] = clamp(int(.1, swayPos[1], self.aimDiff[2]), -swayLimit, swayLimit)
		swayPos[3] = clamp(int(.1, swayPos[3], -self.aimDiff[1]), -swayLimit, swayLimit)

		angTarget = self.aimDiff*self.ironMul

		posTarget = bobPos*5*self.ironMul + restPos*rest*self.ironMul + swayPos*(self.weaponLength or 8)*self.ironMul
		posOutput = posOutput + self.originMod
		posOutput = LerpVector(.05, posOutput, posTarget)
		angOutput = LerpAngle(.1, angOutput, angTarget)

		local Right 	= ang:Right()
		local Up 		= ang:Up()
		local Forward 	= ang:Forward()	

		ang:RotateAroundAxis(ang:Right(), angOutput[1])
		ang:RotateAroundAxis(ang:Up(), angOutput[2])
		ang:RotateAroundAxis(ang:Forward(), angOutput[3])
		
	--	ang:Normalize()

		pos = pos + posOutput.x * Right
		pos = pos + posOutput.y * Forward
		pos = pos + posOutput.z * Up

		return pos, ang
	end
	
end