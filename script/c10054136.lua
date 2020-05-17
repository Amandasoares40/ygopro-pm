--Town Map (Boundaries Crossed 136/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--turn prize
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.PrizeFilter(Card.IsFacedown),LOCATION_PRIZE,0),scard.op1)
end
scard.trainer_item=true
--turn prize
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetPrize(tp):Filter(Card.IsFacedown,nil)
	Duel.TurnPrize(g,POS_FACEUP)
end
