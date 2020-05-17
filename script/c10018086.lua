--Low Pressure System (Dragon 86/97)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain hp
	aux.EnableUpdateHP(c,10,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--gain hp
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_G+ENERGY_L)
