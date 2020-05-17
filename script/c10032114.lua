--Speed Stadium (Diamond & Pearl 114/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.DrawTarget(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ct=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then ct=ct+1 end
	until res==RESULT_TAILS
	Duel.Draw(tp,ct,REASON_EFFECT)
end
