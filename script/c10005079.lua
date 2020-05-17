--Sleep! (Team Rocket 79/82)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--asleep
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_rockets_secret_machine=true
--asleep
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(1-tp)
	if chk==0 then return tc and tc:IsCanBeAsleep() end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
