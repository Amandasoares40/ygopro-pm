--Misty's Wish (Gym Challenge 108/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_MISTY)
	--confirm prize (switch prize or draw)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.PrizeFilter(Card.IsFacedown),LOCATION_PRIZE,0),scard.op1)
end
scard.trainer_item=true
--confirm prize (switch prize or draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRMPRIZE)
	local g1=Duel.SelectMatchingPrizeCard(tp,Card.IsFacedown,tp,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g1)
	Duel.BreakEffect()
	if Duel.GetPrize(tp):IsExists(Card.IsFacedown,1,nil) and Duel.SelectYesNo(1-tp,aux.Stringid(sid,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDPRIZE)
		local g2=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
		if g2:GetCount()==0 then return end
		Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
		Duel.SendtoPrize(g2,REASON_EFFECT)
	else
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
