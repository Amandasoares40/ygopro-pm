--Tropical Wind (Black Star Promo Nintendo 026)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove counter, asleep
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--remove counter, asleep
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivePokemon(tp) or Duel.GetActivePokemon(1-tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetActivePokemon(tp)
	local tc2=Duel.GetActivePokemon(1-tp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc1:RemoveCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
		tc2:RemoveCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	else
		tc1:ApplySpecialCondition(tp,SPC_ASLEEP)
		tc2:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
