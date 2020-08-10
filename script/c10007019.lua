--Koga (Gym Challenge 19/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_KOGA)
	--gain effect
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_item=true
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--poisoned
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+sid)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--poisoned
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_POISONED)
end
