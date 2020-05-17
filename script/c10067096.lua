--All-Night Party (BREAKpoint 96/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--remove asleep, heal
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckCardFunction(aux.ActivePokemonFilter(scard.healfilter),LOCATION_ACTIVE,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--remove asleep, heal
function scard.healfilter(c)
	return c:IsAsleep() and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetActivePokemon(tp)
	tc:RemoveSpecialCondition(tp,SPC_ASLEEP)
	Duel.HealDamage(tp,tc,30,REASON_EFFECT)
end
