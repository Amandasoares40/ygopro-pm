--Magneton (Base Set 9/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--paralyzed
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.length=3.30
scard.evolves_from=CARD_MAGNEMITE
scard.evolution_list1={["Basic"]=CARD_MAGNEMITE,["Stage 1"]=CARD_MAGNETON,["Stage 2"]=CARD_MAGNEZONE}
scard.weakness_x2={ENERGY_F}
--paralyzed
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,30)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	local g=Duel.GetBenchedPokemon()
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,20,tc)
	end
	Duel.AttackDamage(e,80,e:GetHandler())
end
