--Emcee's Chatter (Unleashed 73/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=(Duel.TossCoin(tp,1)==RESULT_HEADS and 3 or 2)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
