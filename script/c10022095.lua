--R Energy (Team Rocket Returns 95/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_DARK,SETNAME_ROCKETS),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_D,2,aux.FilterBoolFunction(Card.IsInPlay))
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,10,aux.SelfSetCardCondition(SETNAME_DARK,SETNAME_ROCKETS))
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.SelfSetCardCondition(SETNAME_DARK,SETNAME_ROCKETS))
end
scard.energy_special=true
