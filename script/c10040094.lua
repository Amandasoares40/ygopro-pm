--Sunyshore City Gym (Rising Rivals 94/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--ignore resistance
	aux.EnableEffectCustom(c,EFFECT_IGNORE_RESISTANCE,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--no weakness
	aux.EnableEffectCustom(c,EFFECT_NO_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--ignore resistance, no weakness
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_L)
