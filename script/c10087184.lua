--Team Yell Grunt (Sword & Shield 184/202)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,0,LOCATION_INPLAY),scard.op1)
end
scard.trainer_supporter=true
--return
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(scard.thfilter,1,nil)
end
function scard.thfilter(c)
	return c:IsEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(tp,0,1):Filter(scard.thfilter,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(tp,sg)
end
