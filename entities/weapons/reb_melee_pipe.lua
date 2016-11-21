AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Pipe"
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

SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.7
SWEP.Primary.Automatic = true
SWEP.isBlunt = true

SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.WorldModel = Model("models/props_canal/mattpipe.mdl")
SWEP.weaponLength = 0.5
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.originMod = Vector(0, -3, 4)
SWEP.VElements = {
	["pipe"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 2.2, -6.7), angle = Angle(8.182, -97.014, -3.507), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}