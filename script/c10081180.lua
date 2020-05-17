--Life Forest Prism Star (Lost Thunder 180/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--stadium
	aux.EnableStadiumAttribute(c)
	--heal, remove all special conditions
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--immune to effects
	aux.EnableEffectImmune(c,scard.val1,LOCATION_STADIUM)
end
--heal, remove all special conditions
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEnergyType(ENERGY_G)
		and (c:IsCanBeHealed() or c:IsAffectedBySpecialCondition())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_HEAL)
	local g=Duel.SelectMatchingCard(tp,scard.healfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.HealDamage(tp,g,60,REASON_EFFECT)
	g:GetFirst():RemoveSpecialCondition(tp,SPC_ALL)
end
--immune to effects
function scard.val1(e,te)
	local tc=te:GetHandler()
	return te:IsActivated() and (tc:IsItem() or tc:IsSupporter())
end
