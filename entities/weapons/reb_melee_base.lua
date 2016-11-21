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

SWEP.ViewModel = Model("models/weapons/v_crowbar.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")

SWEP.UseHands = false
SWEP.originMod = Vector(0, 0, 0)
SWEP.weaponLength = 8
SWEP.isBlunt = false

local swayLimit = 11
function SWEP:Precache()
	util.PrecacheSound("weapons/crowbar/crowbar_impact1.wav")
	util.PrecacheSound("weapons/crowbar/crowbar_impact2.wav")
	util.PrecacheSound("reb/weapons/swing_melee_blunt1.wav")
	util.PrecacheSound("reb/weapons/swing_melee_blunt2.wav")
	util.PrecacheSound("reb/weapons/swing_melee_blunt3.wav")
	util.PrecacheSound("reb/weapons/swing_melee_sharp1.wav")
	util.PrecacheSound("reb/weapons/swing_melee_sharp2.wav")
	util.PrecacheSound("reb/weapons/swing_melee_sharp3.wav")
	util.PrecacheSound("npc/zombie/claw_strike1.wav")
	util.PrecacheSound("npc/zombie/claw_strike2.wav")
	util.PrecacheSound("npc/zombie/claw_strike3.wav")
	util.PrecacheSound("npc/vort/foot_hit.wav")
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	
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

local cureffect = ""

function SWEP:PrimaryAttack()	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:ViewPunch(Angle(1, 0, 0.125))
	if self.isBlunt then
		self:EmitSound("reb/weapons/swing_melee_blunt"..math.random(1, 3)..".wav")
	else
		self:EmitSound("reb/weapons/swing_melee_sharp"..math.random(1, 2)..".wav")
	end

	self.Owner:LagCompensation(true)
		local data = {}
			data.start = self.Owner:GetShootPos()
			data.endpos = data.start + self.Owner:GetAimVector()*83
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