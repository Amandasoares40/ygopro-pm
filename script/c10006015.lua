--Brock (Gym Heroes 15/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BROCK)
	--remove counter
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.ctfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--remove counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,LOCATION_INPLAY,0,nil)
	for tc in aux.Next(g) do
		tc:RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
	end
end
