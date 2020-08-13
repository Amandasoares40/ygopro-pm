--Exeggutor (Jungle 35/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,6.70)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--switch
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_EXEGGCUTE
scard.evolution_list1={["Basic"]=CARD_EXEGGCUTE,["Stage 1"]=CARD_EXEGGUTOR}
scard.weakness_x2={ENERGY_R}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.SwitchPokemon(tp,tp)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup()
	local ct=g:GetSum(Card.GetEnergyCount,nil)
	local dam=0
	for i=1,ct do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+1 end
	end
	Duel.AttackDamage(e,20*dam)
end
