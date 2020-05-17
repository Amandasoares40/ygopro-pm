--Triple Acceleration Energy (Unbroken Bonds 190/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEvolution),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C,3,aux.FilterBoolFunction(Card.IsEvolution))
end
scard.energy_special=true
