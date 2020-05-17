--Great Potion (Unified Minds 198/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.ActivePokemonFilter(scard.healfilter),LOCATION_ACTIVE,0),scard.op1)
end
scard.trainer_item=true
--heal
function scard.healfilter(c)
	return c:IsPokemonGX() and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.HealDamage(tp,Duel.GetActivePokemon(tp),50,REASON_EFFECT)
end
