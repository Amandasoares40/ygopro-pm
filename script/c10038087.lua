--Marley's Request (Stormfront 87/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.thfilter,LOCATION_DPILE,0,2),scard.op1)
end
scard.trainer_supporter=true
--to hand
function scard.thfilter(c)
	return c:IsTrainer() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DPILE,0,nil)
	local sg1=nil
	if g:GetClassCount(Card.GetOriginalCode)>=2 then
		local sg2=aux.SelectUnselectGroup(g,e,tp,2,2,aux.CardNameClassCheck,1,tp,HINTMSG_CONFIRM)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOOPPOHAND)
		sg1=sg2:Select(1-tp,1,1,nil)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		sg1=g:Select(tp,1,1,nil)
	end
	Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg1)
end
