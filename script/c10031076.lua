--Glacia's Stadium (Power Keepers 76/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--no weakness
	aux.EnableEffectCustom(c,EFFECT_NO_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--no weakness
function scard.tg1(e,c)
	return not c:IsPokemonex() and c:IsEnergyType(ENERGY_W)
end
