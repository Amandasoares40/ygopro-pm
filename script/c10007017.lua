--Blaine (Gym Challenge 17/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE)
	--get effect
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_item=true
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--blaine
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BLAINE)
	e1:SetTargetRange(LOCATION_ALL,0)
	e1:SetTarget(scard.tg1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--blaine
function scard.tg1(e,c)
	return c:IsInPlay() and c:IsPokemon() and c:IsSetCard(SETNAME_BLAINE) or c:IsEnergy(ENERGY_R)
end
