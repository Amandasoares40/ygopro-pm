--Nita (Team Up 151/181)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.ActivePokemonFilter(scard.cfilter),0,LOCATION_ACTIVE),scard.op1,scard.con1)
end
scard.trainer_supporter=true
--to deck
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	return tc and tc:IsBasicPokemon()
end
function scard.cfilter(c)
	return c:GetAttachedGroup():IsExists(scard.tdfilter,1,nil)
end
function scard.tdfilter(c)
	return c:IsEnergy() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	local g=tc:GetAttachedGroup():Filter(scard.tdfilter,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
end
