--Energy Reset (Fates Collide 98/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--return
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(scard.retfilter,1,nil)
end
function scard.retfilter(c)
	return c:IsEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(tp,1,0):Filter(scard.retfilter,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,1,g:GetCount(),nil)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
