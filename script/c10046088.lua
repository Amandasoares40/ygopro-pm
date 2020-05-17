--Seeker (Triumphant 88/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.BenchedPokemonFilter(Card.IsAbleToHand),LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_supporter=true
--return
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.return_card(tp)
	scard.return_card(1-tp)
end
function scard.return_card(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.GetBenchedPokemon(tp):FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:Merge(g:GetFirst():GetAttachedGroup())
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
