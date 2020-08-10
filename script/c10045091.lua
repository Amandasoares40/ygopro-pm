--Alph Lithograph (Undaunted THREE/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.thfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsStadium() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(Duel.GetStadiumCard(),PLAYER_OWNER,REASON_EFFECT)
end
