--Ivysaur (Base Set 30/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_G,ENERGY_C,ENERGY_C)
	--poisoned
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_G)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.length=3.30
scard.evolves_from=CARD_BULBASAUR
scard.evolution_list1={["Basic"]=CARD_BULBASAUR,["Stage 1"]=CARD_IVYSAUR,["Stage 2"]=CARD_VENUSAUR}
scard.weakness_x2={ENERGY_R}
--poisoned
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_POISONED)
	end
end
