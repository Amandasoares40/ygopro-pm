--Drake's Stadium (Power Keepers 72/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce damage
	aux.EnableUpdateDamage(c,EFFECT_UPDATE_DEFEND_AFTER,-10,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--reduce damage
function scard.tg1(e,c)
	return c:IsActive() and c:IsEnergyType(ENERGY_C)
end
