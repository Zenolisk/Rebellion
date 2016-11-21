GM.Name = "Rebellion"
GM.Author = "Zenolisk"
GM.Email = ""
GM.Website = ""

hook.Add("Move", "CrouchRun", function(client, mv)
	if (client:GetMoveType() == 8) then return end
	if client:Crouching() then
		if (client:KeyDown(IN_FORWARD) and client.sprint == true) then
			client:SetWalkSpeed(reb.config.walkSpeed + 165)
		else
			client:SetWalkSpeed(reb.config.walkSpeed)
		end
	elseif (client.sprint == true and client:IsOnGround() and !client:Crouching() and client:KeyDown(IN_FORWARD)) then
		client:SetWalkSpeed(reb.config.sprintSpeed)
	else
		client:SetWalkSpeed(reb.config.walkSpeed)
	end
end)

if (SERVER) then

	hook.Add("KeyPress","SprintTap",function(client,key)
		if (!client:Alive()) then return end
		if key == IN_FORWARD then
			if client.lastPress then

				if client.lastPress+0.5 > CurTime() then

					client.sprint = true
					client.lastPress = nil
				else
					client.sprint = false
					client.lastPress = CurTime()
				end
			else
				client.sprint = false
				client.lastPress = CurTime()
			end
		end
	end)
	
	hook.Add("PlayerSpawn","Sprint_Spawn", function(client)
		client.sprint = false
	end)

end

function GM:ShowSpare2(client)
	net.Start("reb_inventory")
	net.Send(client)
end

