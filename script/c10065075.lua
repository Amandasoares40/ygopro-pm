--Hex Maniac (Ancient Origins 75/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain effect
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_supporter=true
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable ability
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_NO_ABILITY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE_ABILITY)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATIONS_PHDP,LOCATIONS_PHDP)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsHasAbility))
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e2,tp)
end
