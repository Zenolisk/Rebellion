AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Crowbar"
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
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.7
SWEP.Primary.Automatic = true
SWEP.isBlunt = true

SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")
SWEP.weaponLength = 0.5
SWEP.originMod = Vector(0, -3, 4)
SWEP.UseHands = true
