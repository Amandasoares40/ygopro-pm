--Tropical Beach (Black Star Promo BW28)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--draw, end turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--draw, end turn
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if e:GetHandler():IsRelateToEffect(e) and ct>0 and Duel.Draw(tp,ct,REASON_EFFECT)>0 then
		Duel.EndTurn()
	end
end
