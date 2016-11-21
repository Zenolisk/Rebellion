AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Knife"
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
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Damage = 13
SWEP.Primary.Delay = 0.55
SWEP.Primary.Automatic = true
SWEP.isBlunt = false

SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.WorldModel = Model("models/props_canal/mattpipe.mdl")
SWEP.weaponLength = 0.5
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.originMod = Vector(0, 0, 5)
SWEP.VElements = {
	["base"] = { type = "Model", model = "models/props_lab/Cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.599, 1.6, -2), angle = Angle(90, 0, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["base"] = { type = "Model", model = "models/props_lab/Cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.299, 1, -2), angle = Angle(108.7, -5.844, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}