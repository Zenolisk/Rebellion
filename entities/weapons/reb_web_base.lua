AddCSLuaFile()

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true
SWEP.ViewModelFOV		= 70
SWEP.ViewModelFlip		= false
SWEP.CSMuzzleFlashes	= true
SWEP.UseHands = true

SWEP.Author			= "Black Tea | Zenolisk"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.Base				= "weapon_base"
SWEP.RenderGroup = RENDERGROUP_BOTH
SWEP.Category			= "Rebellion"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Primary.Sound			= Sound( "Weapon_Galil.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.1

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.DeployTime = 1
SWEP.MuzSize = .5
SWEP.WMuzSize = .3
SWEP.muzAdjust = Angle(0, 0, 0)
SWEP.originMod = Vector(0, 0, 0)
SWEP.weaponLength = 8

local swayLimit = 11
if (CLIENT) then
	function SWEP:PostDrawViewModel()
		if (!LocalPlayer():ShouldDrawLocalPlayer()) then
			local vm = self.Owner:GetViewModel()
			local at = vm:LookupAttachment("1")
			if (!at) then
				at = vm:LookupAttachment("muzzle")
			end
			local atpos = vm:GetAttachment(at)
			local muzAng = atpos.Ang
			muzAng:RotateAroundAxis(atpos.Ang:Forward(), self.muzAdjust.x)
			muzAng:RotateAroundAxis(atpos.Ang:Right(), self.muzAdjust.y)
			muzAng:RotateAroundAxis(atpos.Ang:Up(), self.muzAdjust.z)
		end
	end

	function SWEP:DrawWorldModelTranslucent()
		local at = self:LookupAttachment("muzzle")
		local atpos = self:GetAttachment(at)

		if (!atpos) then
			at = self:LookupAttachment("1")
			atpos = self:GetAttachment(at)
		end

	end

	EVENT_VMUZZLE = 0
	EVENT_WMUZZLE = 1
	EVENT_SHELL = 2
	EVENT_WSHELL = 2
	local eventTable = {
		[5001] = EVENT_VMUZZLE,
		[5003] = EVENT_WMUZZLE,
		[20] = EVENT_WSHELL,
		[21] = EVENT_SHELL,
	}

	local posOutput = Vector(0, 0, 0)
	local posTarget = Vector(0, 0, 0)
	local angOutput = Angle(0, 0, 0)
	local angTarget = Angle(0, 0, 0)
	local oldAimVec = Vector(0 ,0, 0)
	local viewMoveMul = .01
	local curStep = 0
	local sin, cos = math.sin, math.cos
	local clamp = math.Clamp

	local function int(delta, from, to)
		local intType = type(from)

		if intType == "Angle" then
			from = util_NormalizeAngles(from)
			to = util_NormalizeAngles(to)
		end

		local out = from + (to-from)*delta

		return out
	end

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
		if !self:GetIronsight() then
			posOutput = posOutput + self.originMod
		else
			posOutput = posOutput + self.ironMod
		end
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

function SWEP:AdjustMouseSensitivity()
	if self:GetIronsight() then
		return 0.2
	else
		return 1
	end
end

function SWEP:TranslateFOV( fov )
	if self:GetIronsight() then
		return fov - 25
	else
		return fov
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 1, "Ironsight")
end

function SWEP:Initialize()
	if ( SERVER ) then
		self:SetNPCMinBurst( 30 )
		self:SetNPCMaxBurst( 30 )
		self:SetNPCFireRate( 0.01 )
	else
		self.emitter = ParticleEmitter(Vector(0, 0, 0))
		self.cycle = 0
	end
	
	self:SetHoldType(self.HoldType or "smg")
	self:SetIronsight(false)
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW) 
	self:SetNextPrimaryFire(CurTime() + (self.DeployTime or 1))
	return true
end

function SWEP:Think()	
	local owner = self.Owner
	local vel = owner:GetVelocity():Length()

	if (CLIENT) then
		self.aimAngle = self.Owner:EyeAngles()	
		self.aimDiff = self.aimAngle - self.oldAimAngle
		for i = 1, 3 do
			if (360 - math.abs(self.aimDiff[i]) < 180) then
				if (self.aimDiff[i] < 0) then
					self.aimDiff[i] = self.aimDiff[i] + 360
				else
					self.aimDiff[i] = self.aimDiff[i] - 360
				end
			end
		end
		self.oldAimAngle = self.aimAngle
		self.aimDiff = self.aimDiff
		for i = 1, 3 do
			self.aimDiff[i] = math.Clamp(self.aimDiff[i], -swayLimit, swayLimit)
		end
	end
end

function SWEP:CanReload()
	local clip = self:Clip1()
	local reserve = self:Ammo1()

	return (clip < self.Primary.ClipSize and reserve > 0)
end

function SWEP:Reload()
	self:SetIronsight(false)
	self.Weapon:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:CanPrimaryAttack()
	if ( self.Weapon:Clip1() <= 0 ) then
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
end

function SWEP:GetPrimaryDelay()
	return self.Primary.Delay
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + self:GetPrimaryDelay())
	self.Weapon:SetNextPrimaryFire(CurTime() + self:GetPrimaryDelay())


	if ( !self:CanPrimaryAttack() ) then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	if (!IsFirstTimePredicted()) then
		return
	end

	self.Weapon:EmitSound( self.Primary.Sound, math.random(95,105) )
	self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )
	self:TakePrimaryAmmo( 1 )
end

function SWEP:GetSpread()
	return
end

function SWEP:CSShootBullet( dmg, recoil, numbul, cone )
	numbul 	= numbul or 1
	local velo = self.Owner:GetVelocity():Length()
	local ironMul = (self:GetIronsight() and (self.IronPrecise or .5) or 1)
	local velMul = math.Clamp(self.Owner:GetVelocity():Length() / self.Owner:GetWalkSpeed(), 0, 0.5)
	
	if self.Owner:IsOnGround() then
		cone = cone
	else
		cone = cone * 5
	end
	
	if self:GetIronsight() then
		cone = cone * 0.8
	end
	
	if self.Owner:Crouching() then
		cone = cone * 0.7
	end
	
	if velo <= 10 then
		cone = cone
	elseif velo >= 11 then
		cone = cone * 2.5
	end
	
	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= (self.Owner:EyeAngles() + self.Owner:GetViewPunchAngles()):Forward()
	bullet.Tracer	= 2		
	bullet.TracerName = "Tracer"						
	bullet.Force	= dmg*0.5								
	bullet.Damage	= dmg
	bullet.Spread 	= Vector(cone, cone, cone)
	
	if (CLIENT) then
		self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil * - .5, math.random(recoil* - .05, recoil*.05), 0))
	end
	self.Owner:ViewPunchReset()
	self.Owner:ViewPunch(Angle(math.random(-0.03, 0.03), math.random(-0.03, 0.03), recoil*.3))
	self.Owner:FireBullets( bullet )
	self.Owner:MuzzleFlash()								
	self.Owner:SetAnimation( PLAYER_ATTACK1 )	

	if ( self.Owner:IsNPC() ) then return end
end

SWEP.NextSecondaryAtastck = 0
function SWEP:SecondaryAttack()	
	self:SetIronsight(!self:GetIronsight())
	self.Weapon:SetNextPrimaryFire( CurTime() + .4 )
	self.Weapon:SetNextSecondaryFire( CurTime() + .4 )
end

function SWEP:DrawHUD()
end

-- Anti Nospread/Correctly Predicted Bullet by Willox
-- Willox: http://facepunch.com/member.php?u=257577
local meta = FindMetaTable "Entity"
meta.OldFireBullets = meta.OldFireBullets or meta.FireBullets

local function rand()
	return math.random() * 2 - 1
end

function meta:FireBullets( bullet, suppress )
	local spread = bullet.Spread

	if type(spread) == "Vector" then
		bullet.Spread = vector_origin

		math.randomseed( CurTime() + math.sqrt( bullet.Dir.x ^ 2 * bullet.Dir.y ^ 2 * bullet.Dir.z ^ 2 ) )

		bullet.Dir = bullet.Dir + Vector( spread.x * rand(), spread.y * rand(), spread.z * rand() )
	end

	self:OldFireBullets( bullet, suppress )
end