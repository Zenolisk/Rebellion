
surface.CreateFont( "Reb_HUD_small", {
	font = "Arial",
	extended = false,
	size = ScreenScale(6),
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )

surface.CreateFont( "Reb_HUD_med", {
	font = "Arial",
	extended = false,
	size = ScreenScale(10),
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )

function GM:HUDPaint()
	client = LocalPlayer()
	
	--Simple HUD
	draw.RoundedBox( 5, ScrW() * 0.025,  ScrH() * 0.87, ScrW() * 0.035, ScrH() * 0.045, Color(25,25,25,75)) 
	draw.SimpleTextOutlined(client:Health().."%", "Reb_HUD_med", ScrW() * 0.043,  ScrH() * 0.89, Color(255,200,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))
	draw.RoundedBox( 5, ScrW() * 0.025,  ScrH() * 0.93, ScrW() * 0.035, ScrH() * 0.045, Color(25,25,25,75)) 
	draw.SimpleTextOutlined(client:Armor().."%", "Reb_HUD_med", ScrW() * 0.043,  ScrH() * 0.95, Color(255,200,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))

end

/*

	draw.RoundedBox( 5, ScrW() * 0.015,  ScrH() * 0.92, 64, 64, Color(25,25,25,75)) 
	surface.SetDrawColor(Color(255,180,80,255))
	surface.SetMaterial(Material("reb/ui/health.png"))
	surface.DrawTexturedRect(ScrW() * 0.015,  ScrH() * 0.92, 64, 64)
	
	draw.RoundedBox( 5, ScrW() * 0.055,  ScrH() * 0.92, 64, 64, Color(25,25,25,75)) 
	surface.SetDrawColor(Color(255,180,80,255))
	surface.SetMaterial(Material("reb/ui/armor.png"))
	surface.DrawTexturedRect(ScrW() * 0.055,  ScrH() * 0.92, 64, 64)
	
	draw.RoundedBox( 5, ScrW() * 0.055,  ScrH() * 0.85, 64, 64, Color(25,25,25,75)) 
	surface.SetDrawColor(Color(255,180,80,255))
	surface.SetMaterial(Material("reb/ui/helmet.png"))
	surface.DrawTexturedRect(ScrW() * 0.055,  ScrH() * 0.85, 64, 64)
	
	draw.RoundedBox( 5, ScrW() * 0.015,  ScrH() * 0.85, 64, 64, Color(25,25,25,75)) 
	surface.SetDrawColor(Color(255,180,80,255))
	surface.SetMaterial(Material("reb/ui/backpack.png"))
	surface.DrawTexturedRect(ScrW() * 0.015,  ScrH() * 0.85, 64, 64)


*/

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )

concommand.Add("cl_objectives", function()
	if ObjTable then
	PrintTable(ObjTable)
	else
	print("No table")
	end
end)