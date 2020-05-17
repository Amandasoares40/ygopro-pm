--Holon Circle (Crystal Guardians 79/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--stadium
	aux.EnableStadiumAttribute(c)
	--immune to attacks
	aux.EnableEffectImmune(c,aux.AttackImmuneFilter,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--end attack, discard self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_ATTACK)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--immune to attacks
scard.tg1=aux.TargetBoolFunction(Card.IsActive)
--end attack, discard self
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsActive() and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	Duel.NegatePokemonAttack(ev)
	Duel.SendtoDPile(c,REASON_EFFECT+REASON_DISCARD)
end
