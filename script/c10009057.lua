--Larvitar (Neo Discovery 57/75)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_LARVITAR,["Stage 1"]=CARD_PUPITAR,["Stage 2"]=CARD_TYRANITAR}
scard.evolution_list2={["Basic"]=CARD_LARVITAR,["Stage 1"]=CARD_PUPITAR,["Stage 2"]=CARD_TYRANITAR_EX_OLD}
scard.weakness_x2={ENERGY_G}
scard.resistance_30={ENERGY_L}
