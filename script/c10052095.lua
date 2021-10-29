--Hooligans Jim & Cas (Dark Explorers 95/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, to deck
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_supporter=true
--confirm hand, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local sg=g:RandomSelect(tp,3)
	Duel.ConfirmCards(tp,sg)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
end
