--Reserved Ticket (BREAKthrough 147/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (sort deck)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--search (sort deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
	Duel.ShuffleDeck(tp)
	Duel.MoveSequence(g:GetFirst(),SEQ_DECKTOP)
end
