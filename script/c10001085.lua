--Pokemon Center (Base Set 85/102)
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
	e1:SetTarget(aux.CheckCardFunction(aux.BenchedPokemonFilter(Card.IsCanBeHealed),LOCATION_INPLAY,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_HEAL)
	local g=Duel.GetBenchedPokemon(tp):FilterSelect(tp,Card.IsCanBeHealed,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.HealDamage(tp,g,20,REASON_EFFECT)
end
