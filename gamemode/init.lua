DeriveGamemode("Sandbox") --Change this to base when done testing

reb = reb or {}

AddCSLuaFile("core/sh_hooks.lua")
AddCSLuaFile("core/cl_hooks.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("libs/sh_objective.lua")
AddCSLuaFile("libs/sh_settings.lua")
AddCSLuaFile("libs/sh_anim.lua")
AddCSLuaFile("libs/cl_resources.lua")
AddCSLuaFile("derma/cl_objectives.lua")
AddCSLuaFile("derma/cl_startmenu.lua")
AddCSLuaFile("derma/cl_modelselect.lua")

include("core/sv_hooks.lua")
include("core/sh_hooks.lua")
include("sh_config.lua")
include("libs/sh_objective.lua")
include("libs/sv_resources.lua")
include("libs/sh_settings.lua")
include("libs/sh_anim.lua")