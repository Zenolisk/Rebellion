
net.Receive("reb_inventory", function(length, client)
	if !reb.gui.inventory then
		reb.gui.inventory = vgui.Create("reb_Invetory")
	end
end)

net.Receive("reb_invUpdate", function(data)
	local nettable = net.ReadTable()
	if !inv then
		inv = {}
	end
	inv = nettable
end)

local PANEL = {}
	function PANEL:Init()
	
		self:SetPos(ScrW() * -0.5, ScrH() * 0.1)
		self:SetSize(ScrW() * 0.35, ScrH() * 0.7)
		self:MakePopup()
		self:SetTitle("")
		self:MoveTo( ScrW() * 0.33, ScrH() * 0.1, 0.1, 0.2, 0.5 ) 
		self:ShowCloseButton(true)
		self.Paint = function(panel, w, h)
			surface.SetDrawColor(20, 20, 20, 50)
			surface.DrawRect(0, 0, w , h)
			surface.SetDrawColor(20, 20, 20, 150)
			surface.DrawOutlinedRect(0, 0, w , h)
			surface.SetDrawColor(255, 255, 255, 225)
			surface.SetMaterial(Material("reb/ui/background.png"))
			surface.DrawTexturedRect(0, 0, w , h)
		end
		
		surface.PlaySound("reb/backpack_open.wav")
		
		local scroll = self:Add( "DScrollPanel" )
		scroll:SetSize( self:GetWide() * 0.9, self:GetTall() * 0.9 )
		scroll:SetPos( 0, 0 )
		
		local amt = 1

		if (inv) then
			for k, v in pairs(inv) do
				amt = amt + 1
				local icon = scroll:Add( "SpawnIcon" )
				icon:SetPos(self:GetWide() * 0.5 + 65*amt, self:GetTall() * 0.5)
				icon:SetSize(64, 64)
				icon:SetModel(v.model)
				icon:SetToolTip(v.name.."\n\nDescription: "..v.desc)
				icon.Paint = function(self, w, h)
					surface.SetDrawColor(20, 20, 20, 150)
					surface.DrawRect(0, 0, w , h)
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetFont( "Default" )
					surface.SetTextPos( w * 0.1, h * 0.1)
					surface.DrawText(v.amount)
				end
				icon.DoClick = function(self)
					local Menu = DermaMenu()
					
					for k2, v2 in pairs(v.functions) do
						Menu:AddOption(v2.text, function()

						net.Start("reb_invUse")
						net.WriteString(v.uniqueID)
						net.WriteString(k2)
						net.SendToServer()
						
						end)
					end
					
					Menu:Open()
				end
			end
		end
			
		/*	
		local button = self:Add( "DButton" )
		button:SetPos(0, 0)
		button:SetSize(self:GetWide(), self:GetTall())
		button:SetText("")
		button.Paint = function(panel, w, h)
			surface.SetDrawColor(0, 0, 0, 0)
			surface.DrawRect(0, 0, w, h)
		end
		button.DoClick = function()
			self:Close()
			surface.PlaySound("physics/cardboard/cardboard_soft2.wav")
		end
		*/
		
	end
	
	function PANEL:OnClose()
		surface.PlaySound("reb/backpack_close.wav")
		reb.gui.inventory = nil
	end
vgui.Register("reb_Invetory", PANEL, "DFrame")