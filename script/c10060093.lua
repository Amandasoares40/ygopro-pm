--Pokemon Center Lady (Flashfire 93/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal, remove all special conditions
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_supporter=true
--heal, remove all special conditions
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and (c:IsCanBeHealed() or c:IsAffectedBySpecialCondition())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_HEAL)
	local g=Duel.SelectMatchingCard(tp,scard.healfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.HealDamage(tp,g,60,REASON_EFFECT)
	g:GetFirst():RemoveSpecialCondition(tp,SPC_ALL)
end
