DeriveGamemode("Sandbox") --Change this to base when done testing

include("sh_util.lua")
AddCSLuaFile("sh_util.lua")
include("sh_config.lua")
AddCSLuaFile("sh_config.lua")

reb.util.IncludeDir("core")
reb.util.IncludeDir("libs")
reb.util.IncludeDir("derma")