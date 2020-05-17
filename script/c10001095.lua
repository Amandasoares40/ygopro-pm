--Switch (Base Set 95/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_SELF),aux.SwitchOperation(PLAYER_SELF,PLAYER_SELF))
end
scard.trainer_item=true
