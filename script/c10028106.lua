--Fire Energy (EX Holon Phantoms 106/110) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_R)
end
scard.energy_basic=true
