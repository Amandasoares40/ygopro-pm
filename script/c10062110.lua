--Xerosic (Phantom Forces 110/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard trainer/energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_supporter=true
--discard trainer/energy
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(scard.dfilter,1,nil)
end
function scard.dfilter(c)
	return c:IsPokemonTool() or c:IsSpecialEnergy()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local g=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.dfilter,1,1,nil)
	Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
end
