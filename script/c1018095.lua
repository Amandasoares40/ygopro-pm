--Champions Festival (Black Star Promo BW95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--heal
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--heal
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetInPlayPokemon(tp):GetCount()>=6
end
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.healfilter,tp,LOCATION_INPLAY,0,nil)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.HealDamage(tp,g,10,REASON_EFFECT)
	end
end
