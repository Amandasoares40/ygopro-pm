--Koga's Trap (Unbroken Bonds 177/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_KOGA)
	--confused, poisoned
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--confused, poisoned
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(1-tp)
	if chk==0 then return tc and (tc:IsCanBeConfused() or tc:IsCanBePoisoned()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_CONFUSED+SPC_POISONED)
end
