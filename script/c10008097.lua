--Sprout Tower (Neo Genesis 97/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce damage
	aux.EnableUpdateDamage(c,EFFECT_UPDATE_ATTACK_BEFORE,-30,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--reduce damage
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_C)
