--Startling Megaphone (Flashfire 97/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard pokemon tool
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.dtfilter,0,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--discard pokemon tool
function scard.dtfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(Card.IsPokemonTool,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(tp,0,1):Filter(Card.IsPokemonTool,nil)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
end
