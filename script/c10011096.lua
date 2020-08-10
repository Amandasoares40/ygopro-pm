--Thought Wave Machine (Neo Destiny 96/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return, end turn
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.ActivePokemonFilter(scard.cfilter),0,LOCATION_ACTIVE),scard.op1)
end
scard.trainer_rockets_secret_machine=true
--return, end turn
function scard.cfilter(c)
	return c:GetAttachedGroup():IsExists(scard.thfilter,1,nil)
end
function scard.thfilter(c)
	return c:IsEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	local g=tc:GetAttachedGroup():Filter(scard.thfilter,nil)
	if g:GetCount()>0 then
		local ct=0
		repeat
			local res=Duel.TossCoin(tp,1)
			if res==RESULT_HEADS then ct=ct+1 end
		until res==RESULT_TAILS
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local sg=g:Select(tp,ct,ct,nil)
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(tp,sg)
	end
	Duel.EndTurn()
end
