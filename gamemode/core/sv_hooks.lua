util.AddNetworkString("ObjUpdate")
util.AddNetworkString("ResUpdate")

function GM:Initialize()

	--Create the Objective Table and fill it.
	local amt = 100 -- Add a config for this later.
	ObjTable = {}
	resources = {
		Food = amt,
		Electronics = amt,
		Chemicals = amt,
		Scraps = amt
	}
	
	--Add a timer to be sure everything exists in the game world before calling it.
	
	timer.Simple(0.1, function()
		resourceSyncToClient()
		for k, v in pairs(ents.FindByClass("reb_objective")) do
			
			table.insert(ObjTable, tonumber(v.index), {description = tostring(v.desc), complete = false})
		end
	end)
	
end

function GM:AcceptInput(ent, put, activator, caller, value)

	--Update Objectives when an Objective changes
	if ent:GetClass() == "reb_objective" and put == "ObjectiveWin" then
	
		table.remove(ObjTable, ent.index)
		table.insert(ObjTable, tonumber(ent.index), {description = tostring(ent.desc), complete = true})

		net.Start("ObjUpdate")
			net.WriteInt(ent.index, 32)
			net.WriteString(ent.desc)
			net.WriteBool(true)
		net.Send(player.GetAll())
	end

end

function GM:PlayerSpawn(client)

	client:SetModel("models/player/group03/male_09.mdl")
	client:SetupHands()

	--Update Objectives for new spawns
	for k, v in pairs(ObjTable) do
		net.Start("ObjUpdate")
			net.WriteInt(k, 32)
			net.WriteString(v.description)
			net.WriteBool(v.complete)
		net.Send(client)
	end
end

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

concommand.Add("sv_objectives", function()
	if ObjTable then
	PrintTable(ObjTable)
	else
	print("No table")
	end
end)