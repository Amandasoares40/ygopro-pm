--Unidentified Fossil (Ultra Prism 134/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(60,SETNAME_FOSSIL),aux.PlayTrainerPokemonOperation(60,SETNAME_FOSSIL))
end
scard.trainer_item=true
