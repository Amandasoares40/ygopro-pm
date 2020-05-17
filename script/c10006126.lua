--Trash Exchange (Gym Heroes 126/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, discard deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToDeck,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to deck, discard deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_DPILE,0,nil)
	local ct=Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,ct,REASON_EFFECT)
end
