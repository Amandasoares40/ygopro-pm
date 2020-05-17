--Wonder Energy (Primal Clash 144/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_Y))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_Y,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_Y))
	--immune to effects
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_EFFECT,aux.AttackImmuneOppoFilter,aux.SelfEnergyTypeCondition(ENERGY_Y))
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_ATTACK_EFFECT_NONDAMAGE,nil,aux.SelfEnergyTypeCondition(ENERGY_Y))
	aux.AddAttachedDescription(c,DESC_IMMUNE_ATTACK_EFFECT_OPPO,aux.SelfEnergyTypeCondition(ENERGY_Y))
end
scard.energy_special=true
