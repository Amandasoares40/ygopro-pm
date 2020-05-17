--Pokemon Nurse (Expedition 145/165)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove counter, discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_supporter=true
--remove counter, discard energy
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local tc=g:GetFirst()
	tc:RemoveCounter(tp,COUNTER_DAMAGE,tc:GetCounter(COUNTER_DAMAGE),REASON_EFFECT)
	local ag=tc:GetAttachedGroup():Filter(Card.IsEnergy,nil)
	Duel.BreakEffect()
	Duel.SendtoDPile(ag,REASON_EFFECT+REASON_DISCARD)
end
