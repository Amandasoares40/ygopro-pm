--Strong Energy (Furious Fists 104/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_F))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_F,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_F))
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,20,aux.SelfEnergyTypeCondition(ENERGY_F))
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.SelfEnergyTypeCondition(ENERGY_F))
end
scard.energy_special=true
