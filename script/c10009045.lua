--Pupitar (Neo Discovery 45/75)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_F)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.length=3.11
scard.evolves_from=CARD_LARVITAR
scard.evolution_list1={["Basic"]=CARD_LARVITAR,["Stage 1"]=CARD_PUPITAR,["Stage 2"]=CARD_TYRANITAR}
scard.evolution_list2={["Basic"]=CARD_LARVITAR,["Stage 1"]=CARD_PUPITAR,["Stage 2"]=CARD_TYRANITAR_EX_OLD}
scard.weakness_x2={ENERGY_G}
scard.resistance_30={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon():Filter(aux.NOT(Card.IsEnergyType),nil,ENERGY_F)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,10,tc,false,false)
	end
end
