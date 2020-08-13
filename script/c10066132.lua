--Noibat (BREAKthrough 132/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.08)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_NOIBAT,["Stage 1"]=CARD_NOIVERN}
scard.break_evolution_list={CARD_NOIVERN,CARD_NOIVERN_BREAK}
scard.weakness_x2={ENERGY_L}
scard.resistance_20={ENERGY_F}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
