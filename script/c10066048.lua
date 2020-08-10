--Pikachu (BREAKthrough 48/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_L)
	--gain effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=1.04
scard.evolution_list1={["Baby"]=CARD_PICHU,["Basic"]=CARD_PIKACHU,["Stage 1"]=CARD_RAICHU}
scard.break_evolution_list={CARD_RAICHU,CARD_RAICHU_BREAK}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_M}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local c=e:GetHandler()
		--immune to attacks
		aux.AddTempEffectImmune(c,c,DESC_IMMUNE_ATTACK,aux.AttackImmuneFilter,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
