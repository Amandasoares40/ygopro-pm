--Space Center (Deoxys 91/107)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--disable poke-body
	aux.EnableEffectCustom(c,EFFECT_DISABLE_POKEBODY,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--disable poke-body
function scard.tg1(e,c)
	return c:IsBasicPokemon() and not c:IsPokemonex() and not c:IsOwnersPokemon() and c:IsHasPokeBody()
end
