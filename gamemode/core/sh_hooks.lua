GM.Name = "Rebellion"
GM.Author = "Zenolisk"
GM.Email = ""
GM.Website = ""

hook.Add("Move", "CrouchRun", function(client, mv)
	if (client:GetMoveType() == 8) then return end
	if client:Crouching() then
		if client:KeyDown(IN_SPEED) then
			client:SetWalkSpeed(reb.config.walkSpeed + 150)
		else
			client:SetWalkSpeed(reb.config.walkSpeed)
		end
	elseif (client.sprint == true and client:IsOnGround() and !client:Crouching() and client:KeyDown(IN_FORWARD)) then
		client:SetWalkSpeed(reb.config.sprintSpeed)
	else
		client:SetWalkSpeed(reb.config.walkSpeed)
	end
end)

function GM:ShowSpare2(client)
	net.Start("reb_inventory")
	net.Send(client)
end