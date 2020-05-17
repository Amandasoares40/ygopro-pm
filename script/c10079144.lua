--Sky Pillar (Celestial Storm 144/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--immune to attacks
	aux.EnableEffectImmune(c,aux.AttackImmuneOppoFilter,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--immune to attacks
scard.tg1=aux.TargetBoolFunction(Card.IsBenched)
