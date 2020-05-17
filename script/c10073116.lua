--Aether Paradise Conservation Area (Guardians Rising 116/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce damage
	aux.EnableUpdateDamage(c,EFFECT_UPDATE_DEFEND_AFTER,-30,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--reduce damage
function scard.tg1(e,c)
	return c:IsBasicPokemon() and c:IsEnergyType(ENERGY_G+ENERGY_L)
end
