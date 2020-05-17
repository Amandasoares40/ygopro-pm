--Forest of Giant Plants (Ancient Origins 74/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--evolve turn played
	aux.EnableEffectCustom(c,EFFECT_EVOLVE_PLAY_TURN,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--evolve first turn
	aux.EnableEffectCustom(c,EFFECT_EVOLVE_FIRST_TURN,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--evolve turn played, evolve first turn
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_G)
