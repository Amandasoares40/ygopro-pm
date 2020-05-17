--Erika's Kindness (Gym Challenge 103/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ERIKA)
	--remove counter
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--remove counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	for tc in aux.Next(g) do
		tc:RemoveCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
