--Mt. Moon (FireRed & LeafGreen 94/112)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--disable poke-power
	aux.EnableEffectCustom(c,EFFECT_DISABLE_POKEPOWER,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--disable poke-power
function scard.tg1(e,c)
	return c:IsMaxHPBelow(70) and c:IsHasPokePower()
end
