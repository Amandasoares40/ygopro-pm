--Enhanced Hammer (Dark Explorers 94/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.defilter,0,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--discard energy
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(Card.IsSpecialEnergy,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local g=Duel.SelectMatchingCard(tp,scard.defilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.DiscardAttached(tp,g,Card.IsSpecialEnergy,1,1,REASON_EFFECT)
end
