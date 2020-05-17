--Steel Shelter (Phantom Forces 105/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--immune to special conditions
	aux.EnableEffectCustom(c,EFFECT_IMMUNE_SPECIAL_CONDITION,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--immune to special conditions
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,TYPE_METAL)
