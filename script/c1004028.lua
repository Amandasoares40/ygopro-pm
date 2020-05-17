--Championship Arena (Black Star Promo Nintendo 028)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--discard hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--discard hand
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(Duel.GetTurnPlayer(),LOCATION_HAND,0)>=8
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if e:GetHandler():IsRelateToEffect(e) and ct>=8 then
		Duel.DiscardHand(tp,nil,ct-7,ct-7,REASON_EFFECT+REASON_DISCARD)
	end
end
