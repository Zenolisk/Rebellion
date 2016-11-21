AddCSLuaFile()


SWEP.PrintName			= "Pipe Pistol"			
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

SWEP.ViewModel			= "models/weapons/c_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.ViewModelBoneMods = {
	["Bullet4"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bullet3"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bullet6"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Cylinder"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bullet5"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Cylinder_release"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bullet1"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bullet2"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["1"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 2.299, -3.701), angle = Angle(-94.676, -11, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = "Model", model = "models/props_junk/propane_tank001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2.299, -3.5), angle = Angle(-100, -11, 0), size = Vector(0.3, 0.28, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["3"] = { type = "Model", model = "models/props_junk/propane_tank001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0.8, -4.5), angle = Angle(-95, -0.5, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.Sound			= Sound( "weapons/flaregun/fire.wav" )
SWEP.Primary.Recoil			= 20
SWEP.Primary.Damage			= 12
SWEP.Primary.NumShots		= 3
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 2
SWEP.Primary.Delay			= 0.14
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

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