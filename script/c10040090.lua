--Bertha's Warmth (Rising Rivals 90/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove counter
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_supporter=true
--remove counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemonSP() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:GetFirst():RemoveCounter(tp,COUNTER_DAMAGE,5,REASON_EFFECT)
end
