--Moonlight Stadium (Great Encounters 100/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--0 retreat cost
	aux.EnableChangeRetreatCost(c,0,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--0 retreat cost
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_P+ENERGY_D)
