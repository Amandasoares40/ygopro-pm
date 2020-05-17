--Pewter City Gym (Gym Heroes 115/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--ignore resistance
	aux.EnableEffectCustom(c,EFFECT_IGNORE_RESISTANCE,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--ignore resistance
scard.tg1=aux.TargetBoolFunction(Card.IsSetCard,SETNAME_BROCK)
