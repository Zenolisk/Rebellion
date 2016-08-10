util.AddNetworkString("ResUpdate")

hook.Add("Initialize", "reb_resources_initialize", function()
if !(SetTable[1].useResources) then return false end
	local amt = 100 -- Add a config for this later.
	resources = {
		Food = amt,
		Electronics = amt,
		Chemicals = amt,
		Scraps = amt
	}
	resourceSyncToClient()
end)
hook.Add("PlayerInitialSpawn", "reb_resources_PlayerInitialSpawn", function(ply)
if !(SetTable[1].useResources) then return false end
	resourceSyncToClient(ply)
end)
function resourceSyncToClient(ply)
	if(ply) then
		net.Start("ResUpdate")
				net.WriteTable(resources)
		net.Send(ply)
	else
		net.Start("ResUpdate")
				net.WriteTable(resources)
		net.Send(player.GetAll())
	end
end

function addResources(res, amt)
	if !(SetTable[1].useResources) then return false end
	local currentRes = resources[res]
	local updated = currentRes + amt
		resources[res] = updated
		resourceSyncToClient()
end
