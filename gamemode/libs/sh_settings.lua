
hook.Add("Initialize", "reb_setinit", function()
	
	--Add a timer to be sure everything exists in the game world before calling it.
	
	SetTable = {}
	
	timer.Simple(0.1, function()
		for k, v in pairs(ents.FindByClass("reb_settings")) do
		
			if k == 0 then
				SetTable = nil
				return
			end
		
			table.insert(SetTable, {loadScreen = tostring(v.screen), playerModel = v.model, timeLimit = v.time})
		end
	end)
	
end)