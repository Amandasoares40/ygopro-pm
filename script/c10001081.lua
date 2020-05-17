--Energy Retrieval (Base Set 81/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.thfilter,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to hand
function scard.thfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DPILE,0,1,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
