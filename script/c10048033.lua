--Panpour (Black & White 33/114)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(30))
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.00
scard.evolution_list1={["Basic"]=CARD_PANPOUR,["Stage 1"]=CARD_SIMIPOUR}
scard.weakness_x2={ENERGY_L}
