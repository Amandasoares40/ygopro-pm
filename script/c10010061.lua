--Healing Field (Neo Revelation 61/64)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--remove counter
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
--remove counter
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivePokemon(tp):IsDamaged() end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.GetActivePokemon(tp):RemoveCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
