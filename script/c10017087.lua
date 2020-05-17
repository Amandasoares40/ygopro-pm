--Lanette's Net Search (Sandstorm 87/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--search (to hand)
function scard.thfilter(c)
	return c:IsBasicPokemon() and not c:IsBabyPokemon() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil)
	local sg=aux.SelectUnselectGroup(g,e,tp,0,3,aux.EnergyTypeClassCheck,1,tp,HINTMSG_ATOHAND)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	else
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOTARGETS)
		Duel.ShuffleDeck(tp)
	end
end
