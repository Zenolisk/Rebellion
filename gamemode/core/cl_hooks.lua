reb.gui = {}

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

	local trace = LocalPlayer():GetEyeTrace()
	if (trace.Entity.ShouldDraw) and (math.Distance(trace.StartPos.x, trace.StartPos.y, trace.HitPos.x, trace.HitPos.y) <= 200) then
		entity = trace.Entity
		entity:textDisplay()
	end
end


local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )