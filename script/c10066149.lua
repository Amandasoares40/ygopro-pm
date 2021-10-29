--Super Rod (BREAKthrough 149/162) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to deck
function scard.tdfilter(c)
	return (c:IsPokemon() or c:IsBasicEnergy()) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,LOCATION_DPILE,0,3,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
