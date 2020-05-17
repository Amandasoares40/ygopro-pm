--Double Full Heal (Sandstorm 86/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove all special conditions
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.ActivePokemonFilter(Card.IsAffectedBySpecialCondition),LOCATION_ACTIVE,0),scard.op1)
end
scard.trainer_item=true
--remove all special conditions
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(tp):RemoveSpecialCondition(tp,SPC_ALL)
end
