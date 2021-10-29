--The Rocket's Trap (Gym Heroes 19/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToDeck,0,LOCATION_HAND),scard.op1)
end
scard.trainer_item=true
--to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_HAND,nil)
	if g:GetCount()==0 or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local sg=g:RandomSelect(tp,1,3)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
end
