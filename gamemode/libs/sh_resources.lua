if (SERVER) then

	util.AddNetworkString("ResUpdate")

end

local meta = FindMetaTable("Player")

hook.Add("PlayerInitialSpawn", "reb_resCTable", function(client)
	client.resources = {
		Food = 0,
		Tech = 0,
		Chemicals = 0,
		Scraps = 0
	}
	PrintTable(client.resources)
end)

function resourceSyncToClient(client)
	if(client) then
		net.Start("ResUpdate")
				net.WriteTable(resources)
		net.Send(client)
	else
		net.Start("ResUpdate")
				net.WriteTable(resources)
		net.Send(player.GetAll())
	end
end

function meta:AddRes(res, amt)
	if !res then
		Error("No Resource Defined")
	end
	
	if !amt then
		amt = 1
	end

	local currentRes = self.resources[res]
	local updated = currentRes + amt
	self.resources[res] = updated
end

function meta:RemoveRes(res, amt)
	if !res then
		Error("No Resource Defined")
	end
	
	if !amt then
		amt = 1
	end

	local currentRes = self.resources[res]
	local updated = currentRes - amt
	self.resources[res] = updated
end

function meta:CheckRes(res)
	if !res then
		--PrintTable(self.resources)
		for k, v in pairs(self.resources) do
			print(k..v)
			return v
		end
	else
		print(self.resources[res])
		return self.resources[res]
	end

	local currentRes = self.resources[res]
	local updated = currentRes - amt
	self.resources[res] = updated
end
concommand.Add("res_check", function(client, cmd, args)
	client:CheckRes(args[1])
end)
concommand.Add("res_add", function(client, cmd, args)
	client:AddRes(args[1], args[2])
end)
concommand.Add("res_remove", function(client, cmd, args)
	client:RemoveRes(args[1], args[2])
end)
