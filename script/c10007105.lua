--Giovanni's Last Resort (Gym Challenge 105/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_GIOVANNI)
	--remove counter, discard hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--remove counter, discard hand
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(SETNAME_GIOVANNI) and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
	local g1=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		local tc=g1:GetFirst()
		local ct=tc:GetCounter(COUNTER_DAMAGE)
		tc:RemoveCounter(tp,COUNTER_DAMAGE,ct,REASON_EFFECT)
	end
	local g2=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.BreakEffect()
	Duel.SendtoDPile(g2,REASON_EFFECT+REASON_DISCARD)
end
