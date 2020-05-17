--Brock's Sandslash (Gym Challenge 36/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BROCK,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20,false,false,false))
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--poisoned
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_F)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.length=3.30
scard.evolves_from=CARD_BROCKS_SANDSHREW
scard.evolution_list1={["Basic"]=CARD_BROCKS_SANDSHREW,["Stage 1"]=CARD_BROCKS_SANDSLASH}
scard.weakness_x2={ENERGY_G}
scard.resistance_30={ENERGY_L}
--poisoned
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,30)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_POISONED)
	end
end
