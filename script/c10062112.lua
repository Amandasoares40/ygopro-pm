--Mystery Energy (Phantom Forces 112/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_P))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_P,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_P))
	--reduce retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_RETREAT_COST,-2,aux.SelfEnergyTypeCondition(ENERGY_P))
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED,aux.SelfEnergyTypeCondition(ENERGY_P))
end
scard.energy_special=true
