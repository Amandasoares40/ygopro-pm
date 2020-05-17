--Lysandre Labs (Forbidden Light 111/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--disable pokemon tool
	aux.EnableEffectCustom(c,EFFECT_DISABLE_POKEMON_TOOL,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--disable pokemon tool
scard.tg1=aux.TargetBoolFunction(Card.IsPokemon)
