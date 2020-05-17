--Koga's Pidgey (Gym Challenge 49/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_KOGA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--to deck, search (to hand)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.length=1.00
scard.weakness_x2={ENERGY_L}
scard.resistance_30={ENERGY_F}
--to deck, search (to hand)
function scard.thfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and not c:IsCode(sid) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	local g1=Group.FromCards(c)
	g1:Merge(c:GetAttachedGroup())
	Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_ATTACK)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_ATTACK)
	Duel.ConfirmCards(1-tp,g2)
end
