--Cyrus's Initiative (Supreme Victors 137/147)
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
	local c1,c2=Duel.TossCoin(tp,2)
	local ct1=c1+c2
	if ct1==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:FilterSelect(tp,Card.IsAbleToDeck,ct1,ct1,nil)
	if ct1==1 then
		Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	else
		local ct2=Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
		Duel.SortDecktop(tp,1-tp,ct2)
		for i=1,ct2 do
			local mg=Duel.GetDecktopGroup(1-tp,ct2)
			Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
		end
	end
	Duel.ShuffleHand(1-tp)
end
