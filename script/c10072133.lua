--Team Skull Grunt (Sun & Moon 133/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, discard hand
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_supporter=true
--confirm hand, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:FilterSelect(tp,Card.IsEnergy,2,2,nil)
	Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
