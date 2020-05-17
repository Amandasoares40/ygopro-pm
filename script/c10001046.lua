--Charmander (Base Set 46/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(30),aux.DiscardAttachedCost(Card.IsEnergy,1,1,ENERGY_R))
	e2:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.length=2.00
scard.evolution_list1={["Basic"]=CARD_CHARMANDER,["Stage 1"]=CARD_CHARMELEON,["Stage 2"]=CARD_CHARIZARD}
scard.weakness_x2={ENERGY_W}
