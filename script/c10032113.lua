--Rival (Diamond & Pearl 113/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--to hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOOPPOHAND)
	local sg=g:FilterSelect(1-tp,Card.IsAbleToHand,3,3,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
