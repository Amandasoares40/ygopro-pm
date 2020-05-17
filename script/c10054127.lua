--Aspertia City Gym (Boundaries Crossed 127/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain hp
	aux.EnableUpdateHP(c,20,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--gain hp
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_C)
--[[
	Note: This card's effect is almost identical to that of "Snowpoint Temple".
]]
