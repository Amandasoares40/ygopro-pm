--Fighting Energy (EX Ruby & Sapphire 105/109) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_F)
end
scard.energy_basic=true
