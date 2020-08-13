--Haxorus (Noble Victories 89/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,5.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(60))
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--paralyzed
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_FRAXURE
scard.evolution_list1={["Basic"]=CARD_AXEW,["Stage 1"]=CARD_FRAXURE,["Stage 2"]=CARD_HAXORUS}
--paralyzed
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local paralyzed=false
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_HEADS then
		paralyzed=true
	elseif c1+c2==RESULT_TAILS then
		return
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,80)
	if tc:IsInPlay() and paralyzed then tc:ApplySpecialCondition(tp,SPC_PARALYZED) end
end
