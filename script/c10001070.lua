--Clefairy Doll (Base Set 70/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(10),aux.PlayTrainerPokemonOperation(10,0,false))
end
scard.trainer_item=true
