--Night Teleporter (Supreme Victors 138/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToDeck,LOCATION_HAND,0,1,c),scard.op1)
end
scard.trainer_item=true
--search (to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	if g1:GetCount()==0 or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	else
		Duel.ShuffleDeck(tp)
	end
end
