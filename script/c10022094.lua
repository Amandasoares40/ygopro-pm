--Dark Metal Energy (Team Rocket Returns 94/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_D+ENERGY_M,1,aux.FilterBoolFunction(Card.IsInPlay))
end
scard.energy_special=true
