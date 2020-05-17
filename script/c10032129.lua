--Darkness Energy (Diamond & Pearl 129/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_D)
end
scard.energy_basic=true
