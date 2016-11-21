AddCSLuaFile()


SWEP.PrintName			= "Pipe Semi Rifle"			
SWEP.Author				= "Zenolisk"
SWEP.Slot				= 1
SWEP.SlotPos			= 1
SWEP.BobScale = 0
SWEP.SwayScale = 0

SWEP.HoldType			= "smg"
SWEP.Base				= "reb_web_base"
SWEP.Category			= "Rebellion"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(3.148, -5.742, 5.741), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -67.778, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 16.666, 125) }
}
SWEP.VElements = {
	["base2"] = { type = "Model", model = "models/props_junk/iBeam01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(1.557, 0, 1), angle = Angle(90, 0, 90), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base3"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-3.636, 0, 0.518), angle = Angle(-90, 0, 0), size = Vector(0.3, 0.625, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_c17/gaspipes006a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.791, 2.596, -1.558), angle = Angle(-90, 90, -78), size = Vector(0.5, 0.7, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["iron"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0.6, 2, -7), angle = Angle(0, 125, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_c17/trappropeller_lever.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(1.5, -3.636, -2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["handle"] = { type = "Model", model = "models/props_c17/trappropeller_lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.5, -3.636, -2), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base2"] = { type = "Model", model = "models/props_junk/iBeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.557, 0, 1), angle = Angle(90, 0, 90), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base3"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-5, 0, 1.6), angle = Angle(-90, 0, 0), size = Vector(0.367, 0.367, 0.367), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_c17/gaspipes006a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.869, 0.518, -4.676), angle = Angle(-106, 0, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["iron"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.6, 2, -7), angle = Angle(0, 125, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.Sound			= Sound( "reb/weapons/semipipe/semipipe_fire1.wav" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 9
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.015
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Delay			= 0.125
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShellType = 0
SWEP.ShellAng = Angle(-15, 0, 0)
SWEP.muzAdjust = Angle(0, 0, 0)
SWEP.originMod = Vector(1, -4, 0)
SWEP.ironMod = Vector(-1.5, -4, 1)
SWEP.MuzSize = 1
SWEP.weaponLength = 5