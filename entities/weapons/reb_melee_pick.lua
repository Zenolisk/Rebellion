AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Pickaxe"
	SWEP.Slot = 1
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Zenolisk"
SWEP.Instructions = "Primary Fire: Strike"
SWEP.Purpose = "Hitting things."
SWEP.Base = "reb_melee_base"

SWEP.HoldType = "melee"

SWEP.Category			= "Rebellion"
SWEP.ViewModelFOV = 59
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.85
SWEP.Primary.Automatic = true
SWEP.isBlunt = false

SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.WorldModel = Model("models/props_canal/mattpipe.mdl")
SWEP.weaponLength = 0.5
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.originMod = Vector(0, -3, 4)
SWEP.VElements = {
	["base"] = { type = "Model", model = "models/props_mining/pickaxe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.2, 1.5, 2.5), angle = Angle(-175, -15, 1.2), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["base"] = { type = "Model", model = "models/props_mining/pickaxe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.799, 1.2, 4), angle = Angle(-167.144, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}