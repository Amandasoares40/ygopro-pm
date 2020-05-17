--Mary's Request (Unseen Forces 86/115)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:IsStage2() and c:IsEvolved()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	if not Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,1,nil) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
