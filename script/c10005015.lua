--Here Comes Team Rocket! (Team Rocket 15/82)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--turn prize
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.PrizeFilter(Card.IsFacedown),LOCATION_PRIZE,LOCATION_PRIZE),scard.op1)
end
scard.trainer_supporter=true
--turn prize
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetPrize():Filter(Card.IsFacedown,nil)
	Duel.TurnPrize(g,POS_FACEUP)
end
