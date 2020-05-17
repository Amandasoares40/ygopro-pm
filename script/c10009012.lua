--Tyranitar (Neo Discovery 12/75)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_D,ENERGY_D,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.length=6.70
scard.evolves_from=CARD_PUPITAR
scard.evolution_list1={["Basic"]=CARD_LARVITAR,["Stage 1"]=CARD_PUPITAR,["Stage 2"]=CARD_TYRANITAR}
scard.resistance_30={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,30*dam)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,50)
	local g=Duel.GetBenchedPokemon()
	for tc in aux.Next(g) do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then
			Duel.AttackDamage(e,30,tc)
		end
	end
end
