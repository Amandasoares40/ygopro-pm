--Tropical Tidal Wave (Black Star Promo Nintendo 027)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard trainer
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.dtfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--discard trainer
function scard.dtfilter(c)
	return c:IsFaceup() and c:IsTrainer()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.dtfilter,tp,LOCATION_INPLAY,0,e:GetHandler())
	local g2=Duel.GetMatchingGroup(scard.dtfilter,tp,0,LOCATION_INPLAY,nil)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.SendtoDPile(g2,REASON_EFFECT+REASON_DISCARD)
	else
		Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD)
	end
end
