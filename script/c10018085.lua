--High Pressure System (Dragon 85/97)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce retreat cost
	aux.EnableUpdateRetreatCost(c,-1,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--reduce retreat cost
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_R+ENERGY_W)
