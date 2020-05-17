--Switch Raft (Dragon Majesty 62/70)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch, heal
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_SELF,scard.swfilter),scard.op1)
end
scard.trainer_item=true
--switch, heal
function scard.swfilter(c)
	return c:IsEnergyType(ENERGY_W)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(tp)
	if Duel.SwitchPokemon(tp,tp,scard.swfilter) then
		Duel.HealDamage(tp,tc,30,REASON_EFFECT)
	end
end
