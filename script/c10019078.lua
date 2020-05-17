--Team Aqua Hideout (Team Magma vs Team Aqua 78/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA)
	--stadium
	aux.EnableStadiumAttribute(c)
	--increase retreat cost
	aux.EnableUpdateRetreatCost(c,1,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--increase retreat cost
scard.tg1=aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SETNAME_TEAM_AQUA))
