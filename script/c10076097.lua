--Peeking Red Card (Crimson Invasion 97/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, to deck, draw
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_item=true
--confirm hand, to deck, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,g)
	if Duel.SelectYesNo(tp,YESNOMSG_TODECK) then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(1-tp)
		Duel.BreakEffect()
		local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
		Duel.Draw(1-tp,ct,REASON_EFFECT)
	else
		Duel.ShuffleHand(1-tp)
	end
end
