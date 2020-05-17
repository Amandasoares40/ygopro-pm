--無人発電所 Abandoned Power Plant
--Power Plant (Unbroken Bonds 183/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--disable ability
	aux.EnableEffectCustom(c,EFFECT_DISABLE_ABILITY,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--disable ability
function scard.tg1(e,c)
	return (c:IsPokemonGX() or c:IsPokemonEX()) and c:IsHasAbility()
end
