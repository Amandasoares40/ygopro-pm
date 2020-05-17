--Super Energy Removal (Base Set 79/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.defilter,0,LOCATION_INPLAY),scard.op1,nil,scard.cost1)
end
scard.trainer_item=true
--discard energy
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.defilter,tp,LOCATION_INPLAY,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local g=Duel.SelectMatchingCard(tp,scard.defilter,tp,LOCATION_INPLAY,0,1,1,nil)
	Duel.HintSelection(g)
	Duel.DiscardAttached(tp,g,Card.IsEnergy,1,1,REASON_COST)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local g=Duel.SelectMatchingCard(tp,scard.defilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.DiscardAttached(tp,g,Card.IsEnergy,1,2,REASON_EFFECT)
end
