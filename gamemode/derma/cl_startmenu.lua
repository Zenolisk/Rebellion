
local urlstring = ""

net.Receive("reb_startmenu", function(length, client)
	urlstring = net.ReadString()
	vgui.Create("reb_StartMenu")
end)

local PANEL = {}
	function PANEL:Init()
		self:SetPos(0, 0)
		self:SetSize(1000, 700)
		self:MakePopup()
		self:Center()
		self:SetTitle("")
		self.Paint = function(panel, w, h)
			surface.SetDrawColor(255, 255, 255, 0)
			surface.DrawRect(0, 0, w , h)
		end
		
		local url = self:Add( "HTML" )
		url:SetPos(0, 0)
		url:SetSize(self:GetWide(), self:GetTall())
		url:OpenURL( urlstring or "https://github.com/Zenolisk/Rebellion" )
		
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
		end
		
	end
vgui.Register("reb_StartMenu", PANEL, "DFrame")