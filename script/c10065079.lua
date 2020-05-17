--Paint Roller (Ancient Origins 79/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard stadium, draw
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.dtfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--discard stadium, draw
function scard.dtfilter(c)
	return c:IsFaceup() and c:IsStadium()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SendtoDPile(Duel.GetStadiumCard(),REASON_EFFECT+REASON_DISCARD)==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
