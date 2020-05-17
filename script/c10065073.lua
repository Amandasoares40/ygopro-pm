--Faded Town (Ancient Origins 73/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--add counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsMegaEvolution()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.ctfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	for tc in aux.Next(g) do
		tc:AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
