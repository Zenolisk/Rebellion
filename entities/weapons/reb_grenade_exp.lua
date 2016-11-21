AddCSLuaFile()

if CLIENT then
	
	SWEP.PrintName = "Pipe Bomb"
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
SWEP.Primary.ThrowEnt = "reb_grenade_exp_ent"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}
SWEP.VElements = {
	["base"] = { type = "Model", model = "models/props_lab/pipesystem03b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2.596, -1.558), angle = Angle(0, 0, -80.65), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["base"] = { type = "Model", model = "models/props_lab/pipesystem03b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1.557, -1.558), angle = Angle(0, 0, -78.312), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
