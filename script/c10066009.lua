--Chespin (BREAKthrough 9/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (to hand)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(30))
	e2:SetAttackCost(ENERGY_G,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
--search (to hand)
function scard.thfilter(c)
	return c:IsEnergy(ENERGY_G) and c:IsAbleToHand()
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
