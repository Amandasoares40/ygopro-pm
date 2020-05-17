--Rough Seas (Primal Clash 137/160)
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
	e1:SetTarget(aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--heal
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEnergyType(ENERGY_W+ENERGY_L) and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(scard.healfilter,tp,LOCATION_INPLAY,0,nil)
	Duel.HealDamage(tp,g,30,REASON_EFFECT)
end
