util.AddNetworkString("reb_startmenu")

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
	
	if (SetTable[1].playerModel) then
		client:SetModel(table.Random(reb.config.playerModel[SetTable[1].playerModel]))
	else
		client:SetModel("models/Humans/Group03/Male_09.mdl")
	end
	
	client:SetupHands()
	
	client:SetCrouchedWalkSpeed(0.5)
	client:SetWalkSpeed(reb.config.walkSpeed)
	client:SetRunSpeed(reb.config.runSpeed)
	client:SetViewOffsetDucked(Vector(0, 0, reb.config.duckHeight))
	
	client:Give("reb_hands")
	
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
