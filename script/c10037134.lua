--Snowpoint Temple (Legends Awakened 134/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain hp
	aux.EnableUpdateHP(c,20,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--gain hp
scard.tg1=aux.NOT(aux.TargetBoolFunction(Card.IsEvolved))
--[[
	Note: This card's effect is similar to that of "Rocket's Hideout".
]]
