--Lib for objectives, from here we control the objective entity and shizzles



if SERVER then
	hook.Add("Initialize", "reb_objinit", function()

--Add a timer to be sure everything exists in the game world before calling it.

	ObjTable = {}

	timer.Simple(0.1, function()
		for k, v in pairs(ents.FindByClass("reb_objective")) do	
			table.insert(ObjTable, tonumber(v.index), {description = tostring(v.desc), status = 0, hide = v.hidden})
		end
	end)

end)
	function GM:ShowHelp(client)
	net.Start("reb_objectives")
	net.Send(client)
	end
	
	function GM:PlayerSpawn(client)

		--Update Objectives for new spawns
		for k, v in pairs(ObjTable) do
			net.Start("reb_objUpdate")
				net.WriteInt(k, 32)
				net.WriteString(v.description)
				net.WriteInt(v.status, 32)
				net.WriteBool(v.hide)
			net.Send(client)
		end
		
		if (SetTable[1].playerMapModel) then
			client:SetModel(table.Random(reb.config.playerModel[SetTable[1].playerMapModel]))
		else
			client:SetModel("models/Humans/Group03/Male_09.mdl")
		end
		
		client:SetupHands()
		
		client:SetCrouchedWalkSpeed(0.5)
		client:SetWalkSpeed(reb.config.walkSpeed)
		client:SetRunSpeed(reb.config.runSpeed)
		
	end
	
	
	concommand.Add("sv_objectives", function()
		if ObjTable then
		PrintTable(ObjTable)
		else
		print("No table")
		end
	end)

	util.AddNetworkString("reb_objUpdate") -- Update network
	util.AddNetworkString("reb_objectives") -- Menu network

	function GM:AcceptInput(ent, put, activator, caller, value)

		--Update Objectives when an Objective changes
		if ent:GetClass() == "reb_objective" then
			if put == "ObjectiveWin" then
		
			table.remove(ObjTable, ent.index)
			table.insert(ObjTable, tonumber(ent.index), {description = tostring(ent.desc), status = 1, hide = ent.hidden})

			net.Start("reb_objUpdate")
				net.WriteInt(ent.index, 32)
				net.WriteString(ent.desc)
				net.WriteInt(1, 32)
				net.WriteBool(false)
			net.Send(player.GetAll())
			elseif put == "ObjectiveFail" then
		
			table.remove(ObjTable, ent.index)
			table.insert(ObjTable, tonumber(ent.index), {description = tostring(ent.desc), status = 2, hide = ent.hidden})

			net.Start("reb_objUpdate")
				net.WriteInt(ent.index, 32)
				net.WriteString(ent.desc)
				net.WriteInt(2, 32)
				net.WriteBool(false)
			net.Send(player.GetAll())
			elseif put == "ObjectiveUnHide" then
		
			table.remove(ObjTable, ent.index)
			table.insert(ObjTable, tonumber(ent.index), {description = tostring(ent.desc), status = ent.status, hide = false})

			net.Start("reb_objUpdate")
				net.WriteInt(ent.index, 32)
				net.WriteString(ent.desc)
				net.WriteInt(ent.status, 32)
				net.WriteBool(false)
			net.Send(player.GetAll())
			elseif put == "ObjectiveHide" then
		
			table.remove(ObjTable, ent.index)
			table.insert(ObjTable, tonumber(ent.index), {description = tostring(ent.desc), status = ent.status, hide = true})

			net.Start("reb_objUpdate")
				net.WriteInt(ent.index, 32)
				net.WriteString(ent.desc)
				net.WriteInt(ent.status, 32)
				net.WriteBool(true)
			net.Send(player.GetAll())
			end
		end
	end
	
else

	net.Receive("reb_objUpdate", function(data)
	local netindex = net.ReadInt(32)
	local netdesc = net.ReadString()
	local netstatus = net.ReadInt(32)
	local nethidden = net.ReadBool()

	if (!netindex) then
		error("NO OBJECTIVE INDEX")
		return
	end
	
	if (!netdesc) then
		error("NO OBJECTIVE DESCRIPTION")
		return
	end
	
	if (!netstatus) then
		error("NO OBJECTIVE STATUS")
		return
	end
	
	if !ObjTable then
		ObjTable = {}
	end
	
	table.remove(ObjTable, netindex)
	table.insert(ObjTable, netindex, {description = tostring(netdesc), status = netstatus, hide = nethidden})
	
	end)
	
end