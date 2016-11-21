AddCSLuaFile()


SWEP.PrintName			= "Waterpipe Shotgun"			
SWEP.Author				= "Zenolisk"
SWEP.Slot				= 2
SWEP.SlotPos			= 2
SWEP.BobScale = 0
SWEP.SwayScale = 0

SWEP.HoldType			= "smg"
SWEP.Base				= "reb_web_base"
SWEP.Category			= "Rebellion"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.UseHands = true

SWEP.ViewModel			= "models/weapons/c_crossbow.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
/*
SWEP.VElements = {
	["base_detail1"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "base", pos = Vector(0, 0, -4.676), angle = Angle(0, 0, 90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_lab/pipesystem01b.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(-1.5, 5.699, -2.6), angle = Angle(6, -100, -40), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_back"] = { type = "Model", model = "models/props_junk/plasticbucket001a.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "base", pos = Vector(0, 0, -15), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_detail1+"] = { type = "Model", model = "models/props_lab/pipesystem02e.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "base", pos = Vector(1.649, -0.5, -7.5), angle = Angle(0, 104.026, 180), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_bottom"] = { type = "Model", model = "models/props_junk/wood_pallet001a_chunkb3.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "base", pos = Vector(-2.597, 0, 0), angle = Angle(0, 90, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
*/
SWEP.VElements = {
	["base_detail"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -6.753), angle = Angle(0, 0, 90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_lab/pipesystem01b.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.675, 4.675, 3.635), angle = Angle(6, -100, -50.26), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_back"] = { type = "Model", model = "models/props_junk/plasticbucket001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -16.105), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_detail2"] = { type = "Model", model = "models/props_lab/pipesystem02e.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0.5, 0, -11), angle = Angle(180, -78.312, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_bottom"] = { type = "Model", model = "models/props_junk/wood_pallet001a_chunkb3.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-2.597, 0, 0), angle = Angle(0, 90, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["base_detail1"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -4.676), angle = Angle(0, 0, 90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_lab/pipesystem01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.699, 0.5, -4.7), angle = Angle(-100, -4, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_back"] = { type = "Model", model = "models/props_junk/plasticbucket001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -15), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_detail1+"] = { type = "Model", model = "models/props_lab/pipesystem02e.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.799, 0, -7), angle = Angle(-180, -90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base_bottom"] = { type = "Model", model = "models/props_junk/wood_pallet001a_chunkb3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-2, 0, 0), angle = Angle(0, 90, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.Sound			= Sound( "weapons/shotgun/shotgun_dbl_fire.wav" )
SWEP.Primary.Recoil			= 60
SWEP.Primary.Damage			= 8
SWEP.Primary.NumShots		= 8
SWEP.Primary.Cone			= 0.15
SWEP.Primary.ClipSize		= 1
SWEP.Primary.Delay			= 4
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShellType = 0
SWEP.ShellAng = Angle(-15, 0, 0)
SWEP.muzAdjust = Angle(0, 0, 0)
SWEP.originMod = Vector(1, -1, 1)
SWEP.ironMod = Vector(-2, -4, 4)
SWEP.MuzSize = 1
SWEP.weaponLength = 10