--Grass Energy (HeartGold & SoulSilver 115/122) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_G)
end
scard.energy_basic=true
