--Holon Legacy (Dragon Frontiers 74/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--stadium
	aux.EnableStadiumAttribute(c)
	--no weakness
	aux.EnableEffectCustom(c,EFFECT_NO_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--disable poke-power
	aux.EnableEffectCustom(c,EFFECT_DISABLE_POKEPOWER,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg2)
end
--no weakness
scard.tg1=aux.TargetBoolFunction(Card.IsSetCard,SETNAME_DELTA)
--disable poke-power
function scard.tg2(e,c)
	return c:IsSetCard(SETNAME_DELTA) and c:IsHasPokePower()
end
