util.AddNetworkString("ResUpdate")

hook.Add("Initialize", "reb_resources_initialize", function()
	local amt = 100 -- Add a config for this later.
	ObjTable = {}
	resources = {
		Food = amt,
		Electronics = amt,
		Chemicals = amt,
		Scraps = amt
	}
	resourceSyncToClient()
end)

function resourceSyncToClient()
	net.Start("ResUpdate")
			net.WriteTable(resources)
	net.Send(player.GetAll())
end

function addResources(res, amt)
	local currentRes = resources[res]
	local updated = currentRes + amt
		resources[res] = updated
		resourceSyncToClient()
end