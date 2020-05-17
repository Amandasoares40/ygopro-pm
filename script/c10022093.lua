--Venture Bomb (Team Rocket Returns 93/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add counter
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_rockets_secret_machine=true
--add counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local s,o=0,LOCATION_INPLAY
	if Duel.TossCoin(tp,1)==RESULT_TAILS then s,o=LOCATION_INPLAY,0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDCOUNTER)
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,s,o,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:GetFirst():AddCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
end
