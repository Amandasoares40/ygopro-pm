--Buck's Training (Legends Awakened 130/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, get effect
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_supporter=true
--draw, get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local c=e:GetHandler()
	--increase damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_DO_MORE_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(10)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_ACTIVE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsActive))
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
