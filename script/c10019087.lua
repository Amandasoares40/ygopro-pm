--Magma Energy (Team Magma vs Team Aqua 87/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_TEAM_MAGMA),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_F+ENERGY_D,2)
end
scard.energy_special=true
