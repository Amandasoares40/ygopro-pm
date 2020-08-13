--Snubbull (Kalos Starter Set 22/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_Y,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_SNUBBULL,["Stage 1"]=CARD_GRANBULL}
scard.weakness_x2={ENERGY_M}
scard.resistance_20={ENERGY_D}
