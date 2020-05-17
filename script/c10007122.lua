--Saffron City Gym (Gym Challenge 118/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTarget(aux.CheckCardFunction(scard.cfilter,LOCATION_INPLAY,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--return
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon()
		and c:IsSetCard(SETNAME_SABRINA) and c:GetAttachedGroup():IsExists(scard.retfilter,1,nil)
end
function scard.retfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local g=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.retfilter,1,1,nil)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
