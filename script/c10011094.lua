--Impostor Professor Oak's Invention (Neo Destiny 94/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm prize (to deck, to prize)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.PrizeFilter(Card.IsAbleToDeck),0,LOCATION_PRIZE),scard.op1)
end
scard.trainer_item=true
--confirm prize (to deck, to prize)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetPrize(1-tp)
	if g1:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g1)
	local sg=g1:Filter(Card.IsAbleToDeck,nil)
	if sg:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_TODECK) then return end
	local ct=Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(1-tp)
	local g2=Duel.GetDecktopGroup(1-tp,ct)
	Duel.SendtoPrize(g2,REASON_EFFECT)
end
