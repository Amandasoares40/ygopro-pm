--Groudon-EX (Dark Explorers 54/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.mega_evolution_list={CARD_GROUDON_EX,CARD_PRIMAL_GROUDON_EX}
scard.weakness_x2={ENERGY_W}
scard.resistance_20={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetBenchedPokemon(1-tp)
	Duel.AttackDamage(e,20)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,10,tc)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=80
	if Duel.GetActivePokemon(1-tp):GetCounter(COUNTER_DAMAGE)>=2 then dam=dam+40 end
	Duel.AttackDamage(e,dam)
end
