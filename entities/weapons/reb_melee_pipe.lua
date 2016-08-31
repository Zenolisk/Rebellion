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

SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.WorldModel = Model("models/props_canal/mattpipe.mdl")
SWEP.weaponLength = 0.5
SWEP.UseHands = true