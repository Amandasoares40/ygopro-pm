--Ninetales (Base Set 12/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,3.70)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--switch
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(80),aux.DiscardAttachedCost(Card.IsEnergy,1,1,ENERGY_R))
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_R,ENERGY_R)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_VULPIX
scard.evolution_list1={["Basic"]=CARD_VULPIX,["Stage 1"]=CARD_NINETALES}
scard.break_evolution_list={CARD_NINETALES,CARD_NINETALES_BREAK}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.SwitchPokemon(tp,1-tp)
end
