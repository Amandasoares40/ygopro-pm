--Holon Ruins (Delta Species 96/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--stadium
	aux.EnableStadiumAttribute(c)
	--draw, discard hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.DrawTarget(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--draw, discard hand
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(SETNAME_DELTA)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	Duel.ShuffleHand(tp)
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
