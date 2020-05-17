--Battle Frontier (Emerald 75/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--disable poke-power
	aux.EnableEffectCustom(c,EFFECT_DISABLE_POKEPOWER,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--disable poke-body
	aux.EnableEffectCustom(c,EFFECT_DISABLE_POKEBODY,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg2)
end
--disable poke-power
function scard.tg1(e,c)
	return c:IsEvolved() and c:IsEnergyType(ENERGY_C+ENERGY_D+ENERGY_M) and c:IsHasPokePower()
end
--disable poke-body
function scard.tg2(e,c)
	return c:IsEvolved() and c:IsEnergyType(ENERGY_C+ENERGY_D+ENERGY_M) and c:IsHasPokeBody()
end
