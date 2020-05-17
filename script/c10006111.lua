--Good Manners (Gym Heroes 111/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.NOT(Card.IsBasicPokemon),LOCATION_HAND,0),scard.op1)
end
scard.trainer_item=true
--confirm hand, search (to hand)
function scard.thfilter(c)
	return c:IsBasicPokemon() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g1:GetCount()==0 or g1:IsExists(Card.IsBasicPokemon,1,nil) then return end
	Duel.ConfirmCards(1-tp,g1)
	Duel.ShuffleHand(tp)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
	if g2:GetCount()>0 then
		Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
	else
		Duel.ShuffleDeck(tp)
	end
end
