--Mountain Ring (Furious Fists 97/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--immune to attack damage
	aux.EnableEffectCustom(c,EFFECT_IMMUNE_ATTACK_DAMAGE,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--immune to attack damage
scard.tg1=aux.TargetBoolFunction(Card.IsBenched)
