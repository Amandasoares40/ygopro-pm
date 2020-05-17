--Aqua Energy (Team Magma vs Team Aqua 86/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_TEAM_AQUA),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_W+ENERGY_D,2)
end
scard.energy_special=true
