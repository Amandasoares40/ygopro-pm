--Counter Catcher (Crimson Invasion 91/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),aux.SwitchOperation(PLAYER_SELF,PLAYER_OPPO),scard.con1)
end
scard.trainer_item=true
--switch
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp)
end
