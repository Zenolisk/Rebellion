AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Author			= "Oskar"
ENT.AdminSpawnable		= true

if (SERVER) then
local res = {
	"food",
	"weapons",
	"scraps"

}
	function ENT:Initialize()
		self:SetModel( "models/items/item_item_crate.mdl" )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:setResource(res[math.random(1, 3)], math.random(20, 100))
	end
	function ENT:Use(activator, ply)
	if activator:KeyDownLast(IN_USE) then return end
	if (not ply:IsPlayer()) then return end
	activator:PrintMessage(HUD_PRINTCENTER, "You are picking up "..self.Amount.." amount of "..self.Resource..".")
	end
	
	function ENT:setResource(res, amt)
		self.Resource = res
		self.Amount = amt
	end
	
	function ENT:GetResource()
		return self.Resource
	end
	function ENT:GetResourceAmount()
		return self.Amount
	end
	
else
	
end
