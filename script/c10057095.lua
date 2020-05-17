--Scoop Up Cyclone (Plasma Blast 95/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.retfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
scard.trainer_ace_spec=true
--return
function scard.retfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.retfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:Merge(g:GetFirst():GetAttachedGroup())
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
