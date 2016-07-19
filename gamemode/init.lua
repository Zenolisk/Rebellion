DeriveGamemode("Sandbox") --Change this to base when done testing

AddCSLuaFile("core/sh_hooks.lua")
AddCSLuaFile("core/cl_hooks.lua")
AddCSLuaFile("sh_config.lua")

include("core/sv_hooks.lua")
include("core/sh_hooks.lua")

