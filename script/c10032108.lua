--Night Pokemon Center (Diamond & Pearl 108/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove counter or discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--remove counter or discard energy
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local tc=g:GetFirst()
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_HEADS then
		tc:RemoveCounter(tp,COUNTER_DAMAGE,tc:GetCounter(COUNTER_DAMAGE),REASON_EFFECT)
	elseif c1+c2==RESULT_TAILS then
		local ag=tc:GetAttachedGroup():Filter(Card.IsEnergy,nil)
		Duel.SendtoDPile(ag,REASON_EFFECT+REASON_DISCARD)
	end
end
