<<<<<<< HEAD
util.AddNetworkString("reb_startmenu")
=======
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
>>>>>>> fb07e4d646c7bea8dcea12e831fbaf470be289cf

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

local painSounds = {
"vo/npc/male01/pain01.wav",
"vo/npc/male01/pain02.wav",
"vo/npc/male01/pain03.wav",
"vo/npc/male01/pain04.wav",
"vo/npc/male01/pain05.wav",
"vo/npc/male01/pain06.wav",
"vo/npc/male01/pain07.wav",
"vo/npc/male01/pain08.wav",
"vo/npc/male01/pain09.wav",
"vo/npc/male01/ow01.wav",
"vo/npc/male01/ow02.wav"
}

function GM:PlayerHurt(client)

	if ((self.nextPain or 0) >= CurTime()) then
		return
	end
		
	self.nextPain = CurTime() + 1
	client:EmitSound(table.Random(painSounds), 70)
	
end

function GM:PlayerDeathSound() 
	return true
end

function GM:PlayerInitialSpawn(client)
	if (SetTable) then
	net.Start("reb_startmenu")
		net.WriteString(SetTable[1].loadScreen)
	net.Send(client)
	end
end

concommand.Add("sv_objectives", function()
	if ObjTable then
	PrintTable(ObjTable)
	else
	print("No table")
	end
end)