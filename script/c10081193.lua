--Whitney (Lost Thunder 193/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.BreakEffect()
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_DPILE,0,e:GetHandler(),sid)
	Duel.Draw(tp,2*ct,REASON_EFFECT)
end
