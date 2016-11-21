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

local swayLimit = 15
if (CLIENT) then
	function SWEP:PostDrawViewModel()
		if (!LocalPlayer():ShouldDrawLocalPlayer()) then
			local vm = self.Owner:GetViewModel()
			local at = vm:LookupAttachment("1")
			if (!at) then
				at = vm:LookupAttachment("muzzle")
			end
			if (!at) then
				return false
			end
			local atpos = vm:GetAttachment(at)
			if (!atpos) then
				return false
			end
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

	local posOutput = Vector(0, 0, 0)
	local posTarget = Vector(0, 0, 0)
	local angOutput = Angle(0, 0, 0)
	local angTarget = Angle(0, 0, 0)
	local curStep = 0
	local sin, cos = math.sin, math.cos
	local clamp = math.Clamp
	local bobPos = Vector()
	local swayPos = Vector()
	local restPos = Vector()
	SWEP.aimDiff = Angle()
	SWEP.oldAimAngle = Angle()
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
		local CT, DIFF = CurTime(), LT - CurTime()
		local vel = clamp(owner:GetVelocity():Length2D()/reb.config.walkSpeed, 0, 1.5)
		local rest = 1 - clamp(owner:GetVelocity():Length2D()/20, 0, 1)
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
		
		ang:Normalize()

		pos = pos + posOutput.x * Right
		pos = pos + posOutput.y * Forward
		pos = pos + posOutput.z * Up

		return pos, ang
	end
	
end

function SWEP:AdjustMouseSensitivity()
	if self:GetIronsight() then
		return 0.3
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

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetMaterial("")
				else
					vm:SetMaterial("invisible")			
				end
			end
		end
		
	end
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW) 
	self:SetNextPrimaryFire(CurTime() + (self.DeployTime or 1))
	local vm = self.Owner:GetViewModel()
	if (self.ShowViewModel == nil or self.ShowViewModel) then
		vm:SetMaterial("")
	else
		vm:SetMaterial("invisible")			
	end
	self:EmitSound("reb/weapons/holster"..math.random(1, 3)..".wav")
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

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	if (!IsFirstTimePredicted()) then
		return
	end

	self.Weapon:EmitSound( self.Primary.Sound, math.random(95,105) )
	self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )
	self:TakePrimaryAmmo( 1 )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:GetSpread()
	return
end

function SWEP:CSShootBullet( dmg, recoil, numbul, cone )
	numbul 	= numbul or 1
	local velo = self.Owner:GetVelocity():Length()
	local ironMul = (self:GetIronsight() and (self.IronPrecise or .5) or 1)
	local velMul = math.Clamp(velo / self.Owner:GetWalkSpeed(), 0, 0.5)
	
	local bullet = {}
	bullet.Src 		= self.Owner:GetShootPos()
	local ang = self.Owner:EyeAngles()
	ang:RotateAroundAxis(ang:Right(),-cone/2 + math.Rand(0,cone))
	ang:RotateAroundAxis(ang:Up(),-cone/2 + math.Rand(0,cone))
	bullet.Dir 		= ang:Forward()
	bullet.Tracer	= 2	
	bullet.TracerName = "Tracer"				
	bullet.Force	= dmg*0.5					
	bullet.Damage	= dmg
	bullet.Spread 	= Vector(cone, cone, cone)
	bullet.Num 		= numbul
	
	print(bullet.Spread)
	
	if (CLIENT) then
		self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil * - .5, math.random(recoil* - .05, recoil*.05), 0))
	end
	self.Owner:ViewPunchReset()
	self.Owner:ViewPunch(Angle(recoil*.3, 0, 0))
	self.Owner:FireBullets( bullet )
	self.Owner:MuzzleFlash()								
	self.Owner:SetAnimation( PLAYER_ATTACK1 )	

	if ( self.Owner:IsNPC() ) then return end
end

function SWEP:SecondaryAttack()	
	self:SetIronsight(!self:GetIronsight())
	if self:GetIronsight() then
		self:EmitSound("reb/weapons/ironout.wav")
	else
		self:EmitSound("reb/weapons/ironin.wav")
	end
	self.Weapon:SetNextPrimaryFire( CurTime() + .4 )
	self.Weapon:SetNextSecondaryFire( CurTime() + .4 )
end

function SWEP:DrawHUD()
end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end