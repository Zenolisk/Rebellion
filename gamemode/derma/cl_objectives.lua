net.Receive("reb_objectives", function(length, client)
	vgui.Create("reb_Objectives")
end)

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

local PANEL = {}
	function PANEL:Init()
		self:SetPos(ScrW() * -0.5, ScrH() * 0.1)
		self:SetSize(ScrW() * 0.35, ScrH() * 0.7)
		self:MakePopup()
		self:SetTitle("")
		self:MoveTo( ScrW() * 0.33, ScrH() * 0.1, 0.1, 0.2, 0.5 ) 
		self:ShowCloseButton(false)
		self.Paint = function(panel, w, h)
			surface.SetDrawColor(200, 200, 200, 255)
			surface.SetMaterial(Material("reb/ui/clipboard.png"))
			surface.DrawTexturedRect(0, 0, w , h)
			
			for i=1,table.Count(ObjTable) do
				if ObjTable[i].hide == false then
					draw.SimpleText("Objective: "..ObjTable[i].description, "Reb_HUD_med", self:GetWide() * 0.5, self:GetTall() * 0.05 + 40*i, 
					ObjTable[i].status == 0 and Color(20, 20, 20, 200) or ObjTable[i].status == 1 and Color(80, 255, 80, 200) or Color(255,80,80,200), 
					TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			
		end
		
		surface.PlaySound("physics/cardboard/cardboard_soft1.wav")
		
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
		
	end
vgui.Register("reb_Objectives", PANEL, "DFrame")