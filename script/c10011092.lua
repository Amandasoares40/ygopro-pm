--Broken Ground Gym (Neo Destiny 92/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--increase retreat cost
	aux.EnableUpdateRetreatCost(c,1,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,aux.TargetBoolFunction(Card.IsBasicPokemon))
end
