--Clefairy (Base Set 5/102)
--WORK IN PROGRESS: Choosing a Pokemon's attack to copy it
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--asleep
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--copy attack
	--not fully implemented
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Baby"]=CARD_CLEFFA,["Basic"]=CARD_CLEFAIRY,["Stage 1"]=CARD_CLEFABLE}
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--asleep
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
--copy attack
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
end
