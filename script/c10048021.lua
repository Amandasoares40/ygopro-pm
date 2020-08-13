--Pansear (Black & White 21/114)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(30))
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_PANSEAR,["Stage 1"]=CARD_SIMISEAR}
scard.weakness_x2={ENERGY_W}
