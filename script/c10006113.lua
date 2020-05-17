--Minion of Team Rocket (Gym Heroes 113/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return or end turn
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.BenchedPokemonFilter(Card.IsAbleToHand),0,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--return or end turn
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_HEADS then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.GetBenchedPokemon(1-tp):FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		g:Merge(g:GetFirst():GetAttachedGroup())
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	else Duel.EndTurn() end
end
