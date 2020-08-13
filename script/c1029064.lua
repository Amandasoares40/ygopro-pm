--Silvally (Black Star Promo SM64)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,7.07)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--search (to hand)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_TYPE_NULL
scard.evolution_list1={["Basic"]=CARD_TYPE_NULL,["Stage 1"]=CARD_SILVALLY}
scard.weakness_x2={ENERGY_F}
--search (to hand)
function scard.thfilter(c)
	return c:IsItem() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_ATTACK)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=90
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+30 end
	Duel.AttackDamage(e,dam)
end
