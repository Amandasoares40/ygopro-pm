--Flower Shop Lady (Undaunted 74/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter1,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_supporter=true
--to deck
function scard.tdfilter1(c)
	return (c:IsPokemon() or c:IsBasicEnergy()) and c:IsAbleToDeck()
end
function scard.tdfilter2(c)
	return c:IsPokemon() and c:IsAbleToDeck()
end
function scard.tdfilter3(c)
	return c:IsBasicEnergy() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,scard.tdfilter2,tp,LOCATION_DPILE,0,3,3,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,scard.tdfilter3,tp,LOCATION_DPILE,0,3,3,nil)
	g1:Merge(g2)
	Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
end
