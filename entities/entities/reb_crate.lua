AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Author			= "Oskar"
ENT.AdminSpawnable		= true
ENT.ShouldDraw			= true

if (SERVER) then
local res = {
	"Food",
	"Scraps",
	"Electronics",
	"Chemicals"

}
	function ENT:Initialize()
		self:SetModel( "models/items/item_item_crate.mdl" )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetTrigger(true)
		if !(self.Resource) then
			self:setResource(res[math.random(1, table.Count(res))], math.random(20, 100))
		end
	end
	function ENT:Use(activator, ply)
	if activator:KeyDownLast(IN_USE) then return end
	if (not ply:IsPlayer()) then return end
	if ( self:IsPlayerHolding() ) then self:SetHolder(nil) return end
	activator:PickupObject( self )
	self:SetHolder(ply)
	activator:PrintMessage(HUD_PRINTCENTER, "You are picking up "..self:GetResourceAmount().." amount of "..self:GetResource()..".")
	end
	
	function ENT:Touch(entity)
		if (self:GetClass() == entity:GetClass()) then
			if entity:IsPlayerHolding() then
				if (self:GetResource() == entity:GetResource()) then
					self:addResource(entity:GetResourceAmount())
					entity:Remove()
				end
			end
		end
	end
	
	function ENT:setResource(res, amt)
		self:SetNWString("Resource", res)
		self:SetNWInt( "Amount", amt)
	end
	
	function ENT:addResource(amt)
		local oldamt = self:GetResourceAmount()
		local new = amt + oldamt
		self:SetNWString("Amount", new)
	end
	
	function ENT:GetResource()
		return self:GetNWString("Resource")
	end
	function ENT:GetResourceAmount()
		return self:GetNWInt("Amount")
	end
	function ENT:SetHolder(ply)
		self.Holder = ply
	end
	function ENT:GetHolder()
	return self.Holder
	end
	
else
	function ENT:GetResource()
		return self:GetNWString("Resource")
	end
	function ENT:GetResourceAmount()
		return self:GetNWInt("Amount")
	end
	function ENT:textDisplay()
	local pos = self:GetPos():ToScreen()
		surface.SetFont( "Reb_HUD_med" )
		surface.SetTextColor( 230, 100, 20, 255 )
		surface.SetTextPos( pos.x, pos.y - 50 )
		surface.DrawText( "Resource Crate" )
		
		surface.SetFont( "Reb_HUD_small" )
		surface.SetTextColor( 0, 200, 20, 255 )
		surface.SetTextPos( pos.x, pos.y - 20 )
		surface.DrawText( "Contains "..self:GetResourceAmount().." amounts of "..self:GetResource().."." )
	end
	
end
