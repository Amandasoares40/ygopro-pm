--Tool Scrapper (Dragons Exalted 116/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard pokemon tool
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.dtfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--discard pokemon tool
function scard.dtfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(Card.IsPokemonTool,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.dtfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,Card.IsPokemonTool,1,2,nil)
	Duel.SendtoDPile(sg2,REASON_EFFECT+REASON_DISCARD)
end
