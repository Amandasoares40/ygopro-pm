--Gold Potion (Boundaries Crossed 140/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.ActivePokemonFilter(Card.IsCanBeHealed),LOCATION_ACTIVE,0),scard.op1)
end
scard.trainer_item=true
scard.trainer_ace_spec=true
--heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.HealDamage(tp,Duel.GetActivePokemon(tp),90,REASON_EFFECT)
end
