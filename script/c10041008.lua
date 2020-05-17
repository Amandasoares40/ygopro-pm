--Rayquaza C (Supreme Victors 8/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard hand
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_C}
scard.resistance_20={ENERGY_F}
--discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	local g=Duel.GetMatchingGroup(Card.IsEnergy,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,YESNOMSG_DISCARDHAND) then
		local ct=Duel.DiscardHand(tp,Card.IsEnergy,1,5,REASON_ATTACK+REASON_DISCARD)
		ct=ct*10
		dam=dam+ct
	end
	Duel.AttackDamage(e,dam)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	if ct==RESULT_TAILS then return end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,50)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and ct~=RESULT_TAILS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,ct,ct,REASON_ATTACK)
	end
end
