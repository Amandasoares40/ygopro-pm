--Town Volunteers (Aquapolis 136/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_supporter=true
--to deck
function scard.tdfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution() or c:IsBasicEnergy()) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,LOCATION_DPILE,0,5,5,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
