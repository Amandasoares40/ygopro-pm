--Alolan Vulpix (Guardians Rising 21/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ALOLAN)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (to hand)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost()
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.00
scard.evolution_list1={["Basic"]=CARD_ALOLAN_VULPIX,["Stage 1"]=CARD_ALOLAN_NINETALES}
scard.evolution_list2={["Basic"]=CARD_ALOLAN_VULPIX,["Stage 1"]=CARD_ALOLAN_NINETALES_GX}
scard.weakness_x2={ENERGY_M}
--search (to hand)
function scard.thfilter(c)
	return c:IsPokemon() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_ATTACK)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
