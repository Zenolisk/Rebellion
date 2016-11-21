AddCSLuaFile()

if CLIENT then
	
	SWEP.PrintName = "Cluster Grenade"
	SWEP.Slot = 5
	SWEP.Slotpos = 1
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 54
	
	SWEP.IconLetter = "Q"

end

SWEP.Spawnable = true
SWEP.HoldType = "grenade"
SWEP.Base = "reb_grenade_base"

SWEP.UseHands = true
SWEP.Category			= "Rebellion"

SWEP.ViewModel			= "models/weapons/c_grenade.mdl"
SWEP.WorldModel			= "models/weapons/w_grenade.mdl"

SWEP.Primary.ThrowForce			= 1000
SWEP.Primary.ClipSize		= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.ThrowEnt = "reb_grenade_cluster_ent"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}
SWEP.VElements = {
	["base"] = { type = "Model", model = "models/props_junk/garbage_plasticbottle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.199, 4.199, 0.518), angle = Angle(180, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["base"] = { type = "Model", model = "models/props_junk/garbage_plasticbottle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 3.635, 1.557), angle = Angle(180, 31.558, -15.195), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}