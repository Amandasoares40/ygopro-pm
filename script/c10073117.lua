--Altar of the Moone (Guardians Rising 117/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce retreat cost
	aux.EnableUpdateRetreatCost(c,-2,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--reduce retreat cost
function scard.tg1(e,c)
	local g=c:GetAttachedGroup()
	return g:IsExists(Card.IsEnergy,1,nil,ENERGY_P+ENERGY_D)
end
