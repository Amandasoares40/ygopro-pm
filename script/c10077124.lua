--Gardenia (Ultra Prism 124/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_supporter=true
--heal
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon()
		and c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil,ENERGY_G) and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_HEAL)
	local g=Duel.SelectMatchingCard(tp,scard.healfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.HealDamage(tp,g,80,REASON_EFFECT)
end
