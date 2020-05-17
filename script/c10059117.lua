--Fairy Garden (XY 117/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--0 retreat cost
	aux.EnableChangeRetreatCost(c,0,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--0 retreat cost
function scard.tg1(e,c)
	return c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil,ENERGY_Y)
end
