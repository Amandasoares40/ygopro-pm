--Cubone (BREAKthrough 77/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=1.04
scard.evolution_list1={["Basic"]=CARD_CUBONE,["Stage 1"]=CARD_MAROWAK}
scard.break_evolution_list={CARD_MAROWAK,CARD_MAROWAK_BREAK}
scard.weakness_x2={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.AttackDamage(e,50)
end
