--Pokemon Park (Aquapolis 131/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--remove counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACH)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--remove counter
function scard.cfilter(c)
	local tc=c:GetAttachedTarget()
	return c:IsEnergy() and c:IsPlayedFromHand() and tc and tc:IsBenched() and tc:IsDamaged()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()==1
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tc=g:GetFirst():GetAttachedTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc then
		tc:RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
	end
end
