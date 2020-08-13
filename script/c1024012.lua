--Froakie (Kalos Starter Set 12/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_W)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_W,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_FROAKIE,["Stage 1"]=CARD_FROGADIER,["Stage 2"]=CARD_GRENINJA}
scard.break_evolution_list={CARD_GRENINJA,CARD_GRENINJA_BREAK}
scard.weakness_x2={ENERGY_G}
