--Boost Energy (Aquapolis 145/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEvolved),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C,3)
	--cannot retreat
	aux.AddSingleAttachedEffect(c,EFFECT_CANNOT_RETREAT,nil,aux.SelfEvolvedCondition)
	aux.AddAttachedDescription(c,DESC_CANNOT_RETREAT,aux.SelfEvolvedCondition)
end
scard.energy_special=true
