--Pawniard (Kalos Starter Set 19/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_M)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=1.08
scard.evolution_list1={["Basic"]=CARD_PAWNIARD,["Stage 1"]=CARD_BISHARP}
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
