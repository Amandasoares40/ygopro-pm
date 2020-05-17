--Olympia (Generations 66/83)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch, heal
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--switch, heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(tp)
	if Duel.SwitchPokemon(tp,tp) then
		Duel.HealDamage(tp,tc,30,REASON_EFFECT)
	end
end
