--Ruins of Alph (Undaunted 76/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--no resistance
	aux.EnableEffectCustom(c,EFFECT_NO_RESISTANCE,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--no resistance
scard.tg1=aux.TargetBoolFunction(Card.IsPokemon)
