--Mysterious Fossil (Fossil 62/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(50,SETNAME_FOSSIL),aux.PlayTrainerPokemonOperation(50,SETNAME_FOSSIL))
end
scard.trainer_item=true
scard.evolution_list1={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_AERODACTYL}
scard.evolution_list2={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_AERODACTYL_EX_OLD}
scard.evolution_list3={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_KABUTO,["Stage 2"]=CARD_KABUTOPS}
scard.evolution_list4={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_OMANYTE,["Stage 2"]=CARD_OMASTAR}
scard.break_evolution_list={CARD_OMASTAR,CARD_OMASTAR_BREAK}
