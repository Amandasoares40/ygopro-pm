--Metal Energy (HeartGold & SoulSilver 122/122) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_M)
end
scard.energy_basic=true
