--Steven's Resolve (Celestial Storm 145/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand), end turn
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--search (to hand), end turn
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.EndTurn()
	else
		Duel.ShuffleDeck(tp)
	end
end
