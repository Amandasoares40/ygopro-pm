--Fennekin (Kalos Starter Set 8/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_R)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_FENNEKIN,["Stage 1"]=CARD_BRAIXEN,["Stage 2"]=CARD_DELPHOX}
scard.break_evolution_list={CARD_DELPHOX,CARD_DELPHOX_BREAK}
scard.weakness_x2={ENERGY_W}
