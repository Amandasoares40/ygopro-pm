--Lost Remover (Call of Legends 80/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to lost zone
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,0,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--to lost zone
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(scard.tlfilter,1,nil)
end
function scard.tlfilter(c)
	return c:IsSpecialEnergy() and c:IsAbleToLost()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local g=Duel.SelectMatchingCard(tp,scard.cfilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOLZONE)
	local sg=g:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.tlfilter,1,1,nil)
	Duel.SendtoLost(sg,REASON_EFFECT)
end
