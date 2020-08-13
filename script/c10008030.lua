--Clefairy (Neo Genesis 30/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--search (to hand)
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Baby"]=CARD_CLEFFA,["Basic"]=CARD_CLEFAIRY,["Stage 1"]=CARD_CLEFABLE}
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,10*dam)
end
--search (to hand)
function scard.thfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local ct=0
	for i=1,Duel.GetInPlayPokemon():GetCount() do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+1 end
	end
	if ct==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,ct,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_ATTACK)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
