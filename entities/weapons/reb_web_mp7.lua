AddCSLuaFile()


SWEP.PrintName			= "9MM HK MP7"			
SWEP.Author				= "Zenolisk"
SWEP.Slot				= 2
SWEP.SlotPos			= 1
SWEP.BobScale = 0
SWEP.SwayScale = 0

SWEP.HoldType			= "smg"
SWEP.Base				= "reb_web_base"
SWEP.Category			= "Rebellion"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.UseHands = true

SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= falses

SWEP.Primary.Sound			= Sound( "weapons/smg1/smg1_fire1.wav" )
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 14
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.073
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShellType = 0
SWEP.ShellAng = Angle(-15, 0, 0)
SWEP.muzAdjust = Angle(0, 0, 0)
SWEP.originMod = Vector(-2.5, -4, 0.7)
SWEP.ironMod = Vector(-5, -7, 1)
SWEP.MuzSize = 1
SWEP.weaponLength = 4