--Hyper Devolution Spray (Neo Discovery 73/75)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--devolve (return)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.devfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--devolve (return)
function scard.devfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEvolved() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEVOLVE)
	local g=Duel.SelectMatchingCard(tp,scard.devfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Devolve(g,LOCATION_HAND,nil,REASON_EFFECT)
end
