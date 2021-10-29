--Lysandre's Trump Card (Phantom Forces 99/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter,LOCATION_DPILE,LOCATION_DPILE),scard.op1)
end
scard.trainer_supporter=true
--to deck
function scard.tdfilter(c)
	return c:IsAbleToDeck() and not c:IsCode(sid)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tdfilter,tp,LOCATION_DPILE,LOCATION_DPILE,nil)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
