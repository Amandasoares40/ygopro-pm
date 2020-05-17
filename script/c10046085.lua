--Black Belt (Triumphant 85/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--get effect
	aux.PlayTrainerFunction(c,nil,scard.op1,scard.con1)
end
scard.trainer_supporter=true
--get effect
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--increase damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_DO_MORE_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(40)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_ACTIVE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsActive))
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
