--Gastly (BREAKthrough 58/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--asleep, poisoned
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
end
scard.pokemon_basic=true
scard.height=4.03
scard.evolution_list1={["Basic"]=CARD_GASTLY,["Stage 1"]=CARD_HAUNTER,["Stage 2"]=CARD_GENGAR}
scard.weakness_x2={ENERGY_D}
scard.resistance_20={ENERGY_F}
--asleep, poisoned
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP+SPC_POISONED)
	end
end
