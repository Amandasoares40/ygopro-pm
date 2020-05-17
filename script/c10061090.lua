--Fighting Stadium (Furious Fists 90/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--increase damage
	aux.EnableUpdateDamage(c,EFFECT_UPDATE_ATTACK_ACTIVE_EX_BEFORE,20,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--increase damage
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_F)
