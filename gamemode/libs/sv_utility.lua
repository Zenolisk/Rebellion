entity = entity or {}

function entity.create(ent, pos, model)
local entity = ents.Create( ent )
if ( !IsValid( entity ) ) then return end
if (model) then
entity:SetModel(model)
end
entity:SetPos( pos )
entity:Spawn()
end