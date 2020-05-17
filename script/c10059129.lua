--Team Flare Grunt (XY 129/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.ActivePokemonFilter(scard.defilter),0,LOCATION_ACTIVE),scard.op1)
end
scard.trainer_supporter=true
--discard energy
function scard.defilter(c)
	return c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardAttached(tp,Duel.GetActivePokemon(1-tp),Card.IsEnergy,1,1,REASON_EFFECT)
end
