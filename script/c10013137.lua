--Bill's Maintenance (Expedition 137/165)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,3),nil,aux.SendtoDeckCost(nil,LOCATION_HAND,1))
end
scard.trainer_supporter=true
