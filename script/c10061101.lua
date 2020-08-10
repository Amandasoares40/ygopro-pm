--Tool Retriever (Furious Fists 101/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--return
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(scard.thfilter,1,nil)
end
function scard.thfilter(c)
	return c:IsPokemonTool() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.GetAttachedGroup(tp,1,0):FilterSelect(tp,scard.thfilter,1,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
