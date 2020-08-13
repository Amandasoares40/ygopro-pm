--Fraxure (Noble Victories 87/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,3.03)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_AXEW
scard.evolution_list1={["Basic"]=CARD_AXEW,["Stage 1"]=CARD_FRAXURE,["Stage 2"]=CARD_HAXORUS}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,30*dam)
end
