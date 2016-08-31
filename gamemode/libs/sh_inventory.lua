reb.items = reb.items or {}
reb.items.stored = reb.items.stored or {}

hook.Add("PlayerSpawn", "reb_invSpawn", function(client)

	client.invTable = {}

end)

function reb.items.register(itemTable)

	reb.items.stored[itemTable.uniqueID] = itemTable
	reb.items.stored[itemTable.uniqueID].category = itemTable.category
	reb.items.stored[itemTable.uniqueID].weight = itemTable.weight
	reb.items.stored[itemTable.uniqueID].model = itemTable.model
	reb.items.stored[itemTable.uniqueID].desc = itemTable.desc
	reb.items.stored[itemTable.uniqueID].functions = itemTable.functions
	reb.items.stored[itemTable.uniqueID].data = itemTable.data
	reb.items.stored[itemTable.uniqueID].amount = 0
	
end

function reb.items.load()

	local dir = "rebellion/gamemode/items/"

	for k, v in pairs(file.Find(dir.."*.lua", "LUA")) do
		ITEM = {}			
			reb.util.Include(dir..v)
			
			ITEM.uniqueID = ITEM.uniqueID or string.sub(v, 4, -5)
			ITEM.category = ITEM.category or "misc"
			ITEM.model = ITEM.model or "models/error.mdl"
			ITEM.desc = ITEM.desc or "No Description."
			ITEM.functions = ITEM.functions or {}
			ITEM.data = ITEM.data or {}
			ITEM.amount = 0
			ITEM.functions.drop = {
				text = "Drop",
				run = function(itemTable, client)
					if itemTable.amount >= 1 then
						client:spawnItem(itemTable.uniqueID)
					end
				end
			}
			
			reb.items.register(ITEM)
		ITEM = nil
	end

end

reb.items.load()

local meta = FindMetaTable("Player")

function meta:hasItem(item)
	print(item)

	for k, v in pairs(self.invTable) do
		if table.HasValue(v, item) then
			print("TRUE")
			return true
		end
	end
	print("FALSE")
	return false
end

function meta:spawnItem(item)
	for k, v in pairs(self.invTable) do
		if v.uniqueID == item and self:hasItem(item) then
			local ent = ents.Create("reb_item")
			ent:SetPos(self:GetPos() + Vector(0,0,60))
			ent.uniqueID = v.uniqueID
			ent.model = v.model
			ent.amount = v.amount
			ent:Spawn()
		end
	end
end

function meta:giveItem(item, camount)
	if (!camount) then
		camount = 1
	end
	
	if (!item) then
		print("NOPE")
		return
	end
	
	local inventory = self.invTable

	if (inventory) then
		if self:hasItem(reb.items.stored[item].uniqueID) then
			inventory[item].amount = inventory[item].amount + camount
		else
			inventory[item] = table.Copy(reb.items.stored[item])
			inventory[item].amount = inventory[item].amount + camount
		end
	end

	--Make a new table without the "run" functions

	local tempInv = {}

	tempInv = table.Copy(inventory)
	
	for k,v in pairs(tempInv) do
		for k2,v2 in pairs(v.functions) do
			if table.HasValue(v2, v2.run) then
				v2.run = nil
			end
		end
	end
	
	net.Start("reb_invUpdate")
	net.WriteTable(tempInv)
	net.Send(self)
end

function meta:removeItem(item, camount)
	local inventory = self.invTable
	
	if (!camount) then
		camount = 1
	end
	
	if (!item) then
		print("NOPE")
		return
	end
	
	if (inventory) then
		if self:hasItem(reb.items.stored[item].uniqueID) then
			inventory[item].amount = inventory[item].amount - camount
			if inventory[item].amount <= 0 then
				inventory[item] = nil
			end
		end
	end
	
	net.Start("reb_invUpdate")
	net.WriteTable(inventory)
	net.Send(self)
end

concommand.Add("reb_items", function()
PrintTable(reb.items.stored)
end)

concommand.Add("reb_items_player", function(client)
PrintTable(client.invTable)
end)

concommand.Add("reb_items_hasitem", function(client, cmd, args)
	client:hasItem(args[1])
end)

concommand.Add("reb_items_add", function(client, cmd, args)
client:giveItem(args[1], args[2])
end)

concommand.Add("reb_items_remove", function(client, cmd, args)
client:removeItem(args[1], args[2])
end)