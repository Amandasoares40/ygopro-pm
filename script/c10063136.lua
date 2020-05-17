--Repeat Ball (Primal Clash 136/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BALL)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--search (to hand)
function scard.thfilter(c,...)
	return c:IsPokemon() and c:IsCode(...) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetInPlayPokemon(tp)
	local t={}
	for tc in aux.Next(g1) do
		table.insert(t,tc:GetCode())
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,table.unpack(t))
	if g2:GetCount()>0 then
		Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
	else
		Duel.ShuffleDeck(tp)
	end
end
