anim = anim or {}
anim.classes = anim.classes or {}

function anim.SetModelClass(class, model)
	model = string.lower(model)

	anim.classes[model] = class
end

function anim.GetClass(model)
	return anim.classes[model] or (string.find(model, "female") and "citizen_female" or "citizen_male")
end

-- C++ Weapons do not have their holdtypes accessible by Lua.
local holdTypes = {
	weapon_physgun = "smg",
	weapon_physcannon = "smg",
	weapon_stunstick = "melee",
	weapon_crowbar = "melee",
	weapon_stunstick = "melee",
	weapon_357 = "pistol",
	weapon_pistol = "pistol",
	weapon_smg1 = "smg",
	weapon_ar2 = "smg",
	weapon_crossbow = "smg",
	weapon_shotgun = "shotgun",
	weapon_frag = "grenade",
	weapon_slam = "grenade",
	weapon_rpg = "rpg",
	weapon_bugbait = "melee",
	weapon_annabelle = "shotgun",
	gmod_tool = "pistol"
}

-- We don't want to make a table for all of the holdtypes, so just alias them.
local translateHoldType = {
	melee2 = "melee",
	fist = "melee",
	knife = "melee",
	ar2 = "smg",
	physgun = "smg",
	crossbow = "smg",
	slam = "grenade",
	passive = "normal",
	rpg = "rpg"
}

function util.GetHoldType(weapon)
	local holdType = holdTypes[weapon:GetClass()]

	if (holdType) then
		return holdType
	elseif (weapon.HoldType) then
		return translateHoldType[weapon.HoldType] or weapon.HoldType
	else
		return "normal"
	end
end


anim.SetModelClass("models/Humans/Group03/Male_01.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_02.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_03.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_04.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_05.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_06.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_07.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_08.mdl", "citizen_male")
anim.SetModelClass("models/Humans/Group03/Male_09.mdl", "citizen_male")


-- Male citizen animation tree.
anim.citizen_male = {
	normal = {
		idle = {ACT_IDLE, ACT_IDLE_ANGRY_SMG1},
		idle_crouch = {ACT_COVER_LOW, ACT_COVER_LOW},
		walk = {ACT_WALK, ACT_WALK_AIM_RIFLE_STIMULATED},
		walk_crouch = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
		sprint = {"sprint_all", "sprint_all"},
		run = {ACT_RUN, ACT_RUN_AIM_RIFLE_STIMULATED},
		run_crouch = {ACT_RUN_CROUCH, ACT_RUN_CROUCH}
	},
	pistol = {
		idle = {ACT_IDLE, ACT_IDLE_ANGRY_SMG1},
		idle_crouch = {ACT_COVER_LOW, ACT_COVER_LOW},
		walk = {ACT_WALK, ACT_WALK_AIM_RIFLE_STIMULATED},
		walk_crouch = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
		run = {ACT_RUN, ACT_RUN_AIM_RIFLE_STIMULATED},
		run_crouch = {ACT_RUN_CROUCH, ACT_RUN_CROUCH},
		sprint = {"sprint_all", "sprint_all"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_RELOAD_PISTOL
	},
	smg = {
		idle = {ACT_IDLE_SMG1_RELAXED, ACT_IDLE_ANGRY_SMG1},
		idle_crouch = {ACT_COVER_LOW, ACT_COVER_LOW},
		walk = {ACT_WALK_RIFLE_RELAXED, ACT_WALK_AIM_RIFLE_STIMULATED},
		walk_crouch = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
		run = {ACT_RUN_RIFLE_RELAXED, ACT_RUN_AIM_RIFLE_STIMULATED},
		run_crouch = {ACT_RUN_CROUCH, ACT_RUN_CROUCH},
		sprint = {"sprint_all", "sprint_all"},
		attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		idle = {ACT_IDLE_SHOTGUN_RELAXED, ACT_IDLE_ANGRY_SMG1},
		idle_crouch = {ACT_COVER_LOW, ACT_COVER_LOW},
		walk = {ACT_WALK_RIFLE_RELAXED, ACT_WALK_AIM_RIFLE_STIMULATED},
		walk_crouch = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
		run = {ACT_RUN_RIFLE_RELAXED, ACT_RUN_AIM_RIFLE_STIMULATED},
		run_crouch = {ACT_RUN_CROUCH, ACT_RUN_CROUCH},
		sprint = {"sprint_all", "sprint_all"},
		attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN
	},
	grenade = {
		idle = {ACT_IDLE, ACT_IDLE_MANNEDGUN},
		idle_crouch = {ACT_COVER_LOW, ACT_COVER_LOW},
		walk = {ACT_WALK, ACT_WALK_AIM_RIFLE},
		walk_crouch = {ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM_RIFLE},
		run = {ACT_RUN, ACT_RUN_AIM_RIFLE_STIMULATED},
		run_crouch = {ACT_RUN_CROUCH, ACT_RUN_CROUCH},
		sprint = {"sprint_all", "sprint_all"},
		attack = ACT_RANGE_ATTACK_THROW
	},
	melee = {
		idle = {ACT_IDLE_SUITCASE, ACT_IDLE_ANGRY_MELEE},
		idle_crouch = {ACT_COVER_LOW, ACT_COVER_LOW},
		walk = {ACT_WALK, ACT_WALK_AIM_RIFLE},
		walk_crouch = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
		run = {ACT_RUN, ACT_RUN},
		run_crouch = {ACT_RUN_CROUCH, ACT_RUN_CROUCH},
		sprint = {"sprint_all", "sprint_all"},
		attack = ACT_MELEE_ATTACK_SWING
	},
	glide = ACT_GLIDE
}


local playerMeta = FindMetaTable("Player")

WEAPON_LOWERED = 1
WEAPON_RAISED = 2

local math_NormalizeAngle = math.NormalizeAngle
local string_find = string.find
local string_lower = string.lower
local getAnimClass = anim.GetClass
local getHoldType = util.GetHoldType
local config = config

local Length2D = FindMetaTable("Vector").Length2D

function GM:CalcMainActivity(client, velocity)
	local model = string_lower(client:GetModel())
	local class = getAnimClass(model)

	if (string_find(model, "/player/") or string_find(model, "/playermodel") or class == "player") then
		return self.BaseClass:CalcMainActivity(client, velocity)
	end

	if (client:Alive()) then
		client.CalcSeqOverride = -1

		local weapon = client:GetActiveWeapon()
		local holdType = "normal"
		local action = "idle"
		local length2D = Length2D(velocity)

		if (length2D >= reb.config.sprintSpeed) then
			action = "sprint"
		elseif (length2D >= reb.config.runSpeed) then
			action = "run"
		elseif (length2D >= reb.config.walkSpeed + 20 and client:Crouching()) then
			action = "run"
		elseif (length2D >= reb.config.walkSpeed - 80) then
			action = "walk"
		end

		if (client:Crouching()) then
			action = action.."_crouch"
		end

		local state = WEAPON_RAISED

		if (IsValid(weapon)) then
			holdType = getHoldType(weapon)
			--Possible holster code here
			
			state = WEAPON_RAISED
			
		end
		
		local animClass = anim[class]

		if (!animClass) then
			class = "citizen_male"
		end

		if (!animClass[holdType]) then
			holdType = "normal"
		end

		if (!animClass[holdType][action]) then
			action = "idle"
		end

		local animation = animClass[holdType][action]
		local value = ACT_IDLE

		if (!client:OnGround()) then
			client.CalcIdeal = animClass.glide or ACT_GLIDE
		elseif (client:InVehicle()) then
			if state == WEAPON_RAISED and weapon.Base == "reb_wep_base" then
				client.CalcIdeal = ACT_HL2MP_SIT_SMG1
			else
				client.CalcIdeal = ACT_HL2MP_SIT
			end
		elseif (animation) then
			value = animation[state]

			if (type(value) == "string") then
				client.CalcSeqOverride = client:LookupSequence(value)
			else
				client.CalcIdeal = value
			end
		end
		
		local override = client:GetNWFloat("seq")

		if (override) then
			client.CalcSeqOverride = client:LookupSequence(override)
		end

		if (CLIENT) then
			client:SetIK(false)
		end

		local eyeAngles = client:EyeAngles()
		local yaw = velocity:Angle().yaw
		local normalized = math_NormalizeAngle(yaw - eyeAngles.y)

		client:SetPoseParameter("move_yaw", normalized)

		return client.CalcIdeal or ACT_IDLE, client.CalcSeqOverride or -1
	end
end

if (SERVER) then

	hook.Add("KeyPress","SprintTap",function(client,key)
		if (!client:Alive()) then return end
		if key == IN_FORWARD then
			if client.lastPress then

				if client.lastPress+0.5 > CurTime() then

					client.sprint = true
					client.lastPress = nil
				else
					client.sprint = false
					client.lastPress = CurTime()
				end
			else
				client.sprint = false
				client.lastPress = CurTime()
			end
		end
	end)
	
	hook.Add("PlayerSpawn","Sprint_Spawn", function(client)
		client.sprint = false
	end)

end

function GM:DoAnimationEvent(client, event, data)
	local model = string_lower(client:GetModel())
	local class = getAnimClass(model)

	if (string_find(model, "/player/") or string_find(model, "/playermodel") or class == "player") then
		return self.BaseClass:DoAnimationEvent(client, event, data)
	end

	local weapon = client:GetActiveWeapon()
	local holdType = "normal"
	local class = anim.GetClass(model)

	if (!anim[class]) then
		class = "citizen_male"
	end

	if (IsValid(weapon)) then
		holdType = util.GetHoldType(weapon)
	end

	if (!anim[class][holdType]) then
		holdType = "normal"
	end

	local animation = anim[class][holdType]

	if (event == PLAYERANIMEVENT_ATTACK_PRIMARY) then
		client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, animation.attack or ACT_GESTURE_RANGE_ATTACK_SMG1, true)

		return ACT_VM_PRIMARYATTACK
	elseif (event == PLAYERANIMEVENT_ATTACK_SECONDARY) then
		client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, animation.attack or ACT_GESTURE_RANGE_ATTACK_SMG1, true)

		return ACT_VM_SECONDARYATTACK
	elseif (event == PLAYERANIMEVENT_RELOAD) then
		client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, animation.reload or ACT_GESTURE_RELOAD_SMG1, true)

		return ACT_INVALID
	elseif (event == PLAYERANIMEVENT_JUMP) then
		client.m_bJumping = true
		client.m_bFistJumpFrame = true
		client.m_flJumpStartTime = CurTime()

		client:AnimRestartMainSequence()

		return ACT_INVALID
	elseif (event == PLAYERANIMEVENT_CANCEL_RELOAD) then
		client:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)

		return ACT_INVALID
	end

	return nil
end
