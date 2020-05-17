--Dark City (Unified Minds 193/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--0 retreat cost
	aux.EnableChangeRetreatCost(c,0,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--0 retreat cost
function scard.tg1(e,c)
	return c:IsBasicPokemon() and c:IsEnergyType(ENERGY_D)
end
