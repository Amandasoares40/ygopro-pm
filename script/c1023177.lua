--Karen (Black Star Promo XY177)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter,LOCATION_DPILE,LOCATION_DPILE),scard.op1)
end
scard.trainer_supporter=true
--to deck
function scard.tdfilter(c)
	return c:IsPokemon() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tdfilter,tp,LOCATION_DPILE,LOCATION_DPILE,nil)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
end
