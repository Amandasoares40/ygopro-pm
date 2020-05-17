--Pokemon Tower (Black Star Promo Wizards of the Coast 42)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--cannot to hand
	aux.EnablePlayerEffectCustom(c,EFFECT_CANNOT_TO_HAND,LOCATION_STADIUM,1,1,aux.TargetBoolFunction(Card.IsLocation,LOCATION_DPILE))
end
