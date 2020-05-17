--Battle Compressor Team Flare Gear (Phantom Forces 92/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (discard deck)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--search (discard deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDPile,tp,LOCATION_DECK,0,1,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	end
end
