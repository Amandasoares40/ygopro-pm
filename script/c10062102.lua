--Robo Substitute Team Flare Gear (Phantom Forces 102/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(30),aux.PlayTrainerPokemonOperation(30))
end
scard.trainer_item=true
