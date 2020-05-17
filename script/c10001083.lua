--Maintenance (Base Set 83/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,nil,aux.DrawOperation(PLAYER_SELF,1),nil,aux.SendtoDeckCost(nil,LOCATION_HAND,2))
end
scard.trainer_item=true
