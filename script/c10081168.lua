--Aether Foundation Employee (Lost Thunder 168/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.thfilter,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_supporter=true
--to hand
function scard.thfilter(c)
	return c:IsPokemon() and c:IsSetCard(SETNAME_ALOLAN) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DPILE,0,3,3,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
