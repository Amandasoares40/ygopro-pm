--Ancient Tomb (Hidden Legends 87/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--ignore weakness
	aux.EnableEffectCustom(c,EFFECT_IGNORE_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--ignore weakness
function scard.tg1(e,c)
	return not c:IsPokemonex() and not c:IsOwnersPokemon()
end
