--Mount Lanakila (Burning Shadows 118/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--increase retreat cost
	aux.EnableUpdateRetreatCost(c,1,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--increase retreat cost
scard.tg1=aux.TargetBoolFunction(Card.IsBasicPokemon)
