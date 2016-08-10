hook.Add("HUDPaint", "reb_resources", function()
	if (SetTable[1].useResources) then
	if (resources) then
		drawResources()
	end
	end
end)

function drawResources()
local n = -1
	for k, v in pairs(resources) do
	n = n+1
		draw.SimpleText(k..": "..v, "Reb_HUD_small", ScrW() - 150 , 15 + (n * 15), Color(255, 255, 255, 255))
	end
end

net.Receive("ResUpdate", function(data)
	local resTable = net.ReadTable()
	
	resources = resTable
	
end)