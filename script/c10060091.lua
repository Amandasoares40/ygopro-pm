--Magnetic Storm (Flashfire 91/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--no resistance
	aux.EnableEffectCustom(c,EFFECT_NO_RESISTANCE,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--no resistance
scard.tg1=aux.TargetBoolFunction(Card.IsPokemon)
--[[
	Note: This card's effect is identical to that of "Ruins of Alph".
]]
