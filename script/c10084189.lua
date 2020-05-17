--Bug Catcher (Unified Minds 189/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
