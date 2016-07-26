
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

--Receive Serverside Objective Updates.

net.Receive("ObjUpdate", function(data)
	local index = net.ReadInt(32)
	local desc = net.ReadString()
	local bool = net.ReadBool()

	if (!index) then
		error("NO OBJECTIVE INDEX")
		return
	end
	
	if (!desc) then
		error("NO OBJECTIVE DESCRIPTION")
		return
	end
	
	if !ObjTable then
		ObjTable = {}
	end
	
	table.remove(ObjTable, index)
	table.insert(ObjTable, index, {description = tostring(desc), complete = bool})
end)

net.Receive("ResUpdate", function(data)
	local resTable = net.ReadTable()
	
	resources = resTable
	
end)
	
	

function GM:HUDPaint()
	client = LocalPlayer()
	
	--Simple HUD
	draw.RoundedBox( 5, ScrW() * 0.025,  ScrH() * 0.87, ScrW() * 0.035, ScrH() * 0.045, Color(25,25,25,75)) 
	draw.SimpleTextOutlined(client:Health().."%", "Reb_HUD_med", ScrW() * 0.043,  ScrH() * 0.89, Color(255,200,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))
	draw.RoundedBox( 5, ScrW() * 0.025,  ScrH() * 0.93, ScrW() * 0.035, ScrH() * 0.045, Color(25,25,25,75)) 
	draw.SimpleTextOutlined(client:Armor().."%", "Reb_HUD_med", ScrW() * 0.043,  ScrH() * 0.95, Color(255,200,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))
	
	
	--Objectives
	for i=1,table.Count(ObjTable) do
		draw.SimpleText("Objective: "..ObjTable[i].description, "Reb_HUD_small", 10, ScrH() * 0.01 + 20*i, ObjTable[i].complete and Color(80,255,80,255) or Color(255,80,80,255))
	end
	if (resources) then
		drawResources()
	end
	local trace = LocalPlayer():GetEyeTrace()
	if (trace.Entity.ShouldDraw) and (math.Distance(trace.StartPos.x, trace.StartPos.y, trace.HitPos.x, trace.HitPos.y) <= 200) then
	entity = trace.Entity
	entity:textDisplay()
	end
end

function drawResources()
local n = -1
	for k, v in pairs(resources) do
	n = n+1
		
		draw.SimpleText(k..": "..v, "Reb_HUD_small", ScrW() - 150 , 15 + (n * 15), Color(255, 255, 255, 255))
	
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

concommand.Add("cl_objectives", function()
	if ObjTable then
	PrintTable(ObjTable)
	else
	print("No table")
	end
end)