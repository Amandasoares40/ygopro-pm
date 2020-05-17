--The Rocket's Training Gym (Gym Heroes 104/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS)
	--stadium
	aux.EnableStadiumAttribute(c)
	--increase retreat cost
	aux.EnableUpdateRetreatCost(c,1,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--increase retreat cost
scard.tg1=aux.TargetBoolFunction(Card.IsActive)
