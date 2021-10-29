--Lana's Fishing Rod (Cosmic Eclipse 195/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--to deck
function scard.tdfilter1(c)
	return c:IsPokemon() and c:IsAbleToDeck()
end
function scard.tdfilter2(c)
	return c:IsPokemonTool() and c:IsAbleToDeck()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.tdfilter1,tp,LOCATION_DPILE,0,1,nil)
		and Duel.IsExistingMatchingCard(scard.tdfilter2,tp,LOCATION_DPILE,0,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,scard.tdfilter1,tp,LOCATION_DPILE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,scard.tdfilter2,tp,LOCATION_DPILE,0,1,1,nil)
	g1:Merge(g2)
	Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
