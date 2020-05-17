--Double Dragon Energy (Roaring Skies 97/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_N))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_ALL,2,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_N))
end
scard.energy_special=true
