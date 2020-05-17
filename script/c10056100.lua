--Frozen City (Plasma Freeze 100/116)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--stadium
	aux.EnableStadiumAttribute(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACH)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--add counter
function scard.cfilter(c)
	local tc=c:GetAttachedTarget()
	return c:IsEnergy() and c:IsPlayedFromHand() and tc and not tc:IsSetCard(SETNAME_TEAM_PLASMA)
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
		tc:AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
