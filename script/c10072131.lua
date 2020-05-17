--Rotom Dex (Sun & Moon 131/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROTOM)
	--to deck, to prize
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.PrizeFilter(Card.IsAbleToDeck),LOCATION_PRIZE,0),scard.op1)
end
scard.trainer_item=true
--to deck, to prize
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetPrize(tp):Filter(Card.IsAbleToDeck,nil)
	local ct=Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	if ct==0 then return end
	local g2=Duel.GetDecktopGroup(tp,ct)
	Duel.BreakEffect()
	Duel.SendtoPrize(g2,REASON_EFFECT)
end
