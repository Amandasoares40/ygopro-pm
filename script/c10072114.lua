--Big Malasada (Sun & Moon 114/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal, remove special condition
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--heal, remove special condition
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(tp)
	if chk==0 then return tc and (tc:IsCanBeHealed() or tc:IsAffectedBySpecialCondition()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(tp)
	Duel.HealDamage(tp,tc,20,REASON_EFFECT)
	Duel.SelectRemoveSpecialCondition(tp,tc)
end
