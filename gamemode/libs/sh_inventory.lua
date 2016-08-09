items = {}

hook.Add("PlayerSpawn", "reb_invSpawn", function(client)

	client.invTable = {}

end)

function items.register(class, name, desc, model)
	
	if !name then
		error("ITEM REGISTER: NO NAME SET FOR ONE ITEM")
		return
	end
	
	if !class then
		class = name
	end
	
	if !desc then
		desc = "No Description"
	end
	
	if !model then
		model = "models/weapons/w_crowbar.mdl"
	end
	
	items[#items + 1] = {
	class = class,
	name = name,
	desc = desc,
	model = model
	}
end

meta = getmetatable("Player")

function meta:addItem(class, amount)
	if !self.invTable[class] then self.invTable[class] = 0 end
	local all = self:getAllItems()
	local max = reb.config.invMaxSize

	if all + amount > max then
		self.invTable[class] = self.invTable[class] + (max - all)
		self:DropResource(class,(all + amount) - max)
		print("You cant carry more!")
	else
		self.invTable[class] = self.invTable[class] + amount
	end
end

function meta:addItem(class, amount)
	if !self.invTable[class] then self.invTable[class] = 0 end
	self.invTable[class] = self.invTable[class] - amount
end

function meta:getItem(class)
	if !class then
		return error("NO CLASS")
	end

	return self.invTable[class]
end

function meta:getAllItems()
	local num = 0

	for k,v in pairs(self.invTable) do
		num = num + v
	end

	return num
end