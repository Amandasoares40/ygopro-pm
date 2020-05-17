--Devoured Field (Crimson Invasion 93/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--increase damage
	aux.EnableUpdateDamage(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,10,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--increase damage
function scard.tg1(e,c)
	return c:IsActive() and c:IsEnergyType(ENERGY_D+ENERGY_N)
end
