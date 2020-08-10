--Energy Flow (Gym Heroes 122/132)
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
	return c:IsEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_INPLAY,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	local ct=Duel.GetInPlayPokemon(tp):GetCount()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.thfilter,1,ct,nil)
	Duel.SendtoHand(sg2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg2)
end
