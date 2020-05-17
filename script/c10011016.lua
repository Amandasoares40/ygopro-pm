--Miracle Energy (Neo Destiny 16/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_SHINING,SETNAME_LIGHT),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_ALL,2,aux.FilterBoolFunction(Card.IsInPlay))
end
scard.energy_special=true
