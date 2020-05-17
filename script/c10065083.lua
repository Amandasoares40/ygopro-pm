--Flash Energy (Ancient Origins 83/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_L))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_L,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_L))
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS,nil,aux.SelfEnergyTypeCondition(ENERGY_L))
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS,aux.SelfEnergyTypeCondition(ENERGY_L))
end
scard.energy_special=true
