--Transparent Walls (Gym Challenge 125/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--get effect
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_item=true
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--immune to attack damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_IMMUNE_ATTACK_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_ATTACK_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_INPLAY,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsBenched))
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e2,tp)
end
