--Poochyena (Kalos Starter Set 16/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_D,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=1.08
scard.evolution_list1={["Basic"]=CARD_POOCHYENA,["Stage 1"]=CARD_MIGHTYENA}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
