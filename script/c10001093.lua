--Gust of Wind (Base Set 93/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),aux.SwitchOperation(PLAYER_SELF,PLAYER_OPPO))
end
scard.trainer_item=true
