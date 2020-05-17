--Pokemon Breeder (Base Set 76/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, heal
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw, heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.HealDamage(tp,Duel.GetActivePokemon(tp),20,REASON_EFFECT)
end
