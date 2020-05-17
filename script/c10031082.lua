--Sidney's Stadium (Power Keepers 82/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--cannot be asleep
	aux.EnableEffectCustom(c,EFFECT_IMMUNE_ASLEEP,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--cannot be confused
	aux.EnableEffectCustom(c,EFFECT_IMMUNE_CONFUSED,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--cannot be paralyzed
	aux.EnableEffectCustom(c,EFFECT_IMMUNE_PARALYZED,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--cannot be asleep, confused, paralyzed
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_D)
