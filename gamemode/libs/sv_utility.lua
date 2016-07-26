entity = entity or {}

function entity.create(ent, pos)
local entity = ents.Create( ent )
if ( !IsValid( entity ) ) then return end
entity:SetPos( pos )
entity:Spawn()
end