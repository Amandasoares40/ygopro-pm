--Magneton (Fossil 11/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,3.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20,false,false))
	e1:SetAttackCost(ENERGY_L,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_L,ENERGY_L)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_MAGNEMITE
scard.evolution_list1={["Basic"]=CARD_MAGNEMITE,["Stage 1"]=CARD_MAGNETON,["Stage 2"]=CARD_MAGNEZONE}
scard.weakness_x2={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,100)
	local g=Duel.GetBenchedPokemon()
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,20,tc)
	end
	Duel.AttackDamage(e,100,e:GetHandler())
end
