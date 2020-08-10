--Mirage Stadium (Skyridge 132/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_PRE_RETREAT)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--gain effect
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasCategory(CATEGORY_RETREAT)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(rp,1)==RESULT_TAILS then
		--cannot retreat
		aux.AddTempEffectCustom(e:GetHandler(),re:GetHandler(),DESC_CANNOT_RETREAT,EFFECT_CANNOT_RETREAT,RESET_PHASE+PHASE_END)
	end
end
