--Rainbow Brush (Celestial Storm 141/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (attach), to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--search (attach), to deck
function scard.cfilter(c)
	return c:GetAttachedGroup():IsExists(scard.tdfilter,1,nil)
end
function scard.tdfilter(c)
	return c:IsEnergy() and c:IsAbleToDeck()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.atfilter(c,tc)
	return c:IsBasicEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(tp):Filter(scard.cfilter,nil)
	if g:GetCount()==0 or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	local tc=sg1:GetFirst()
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg2=tc:GetAttachedGroup():FilterSelect(tp,scard.tdfilter,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg3=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DECK,0,0,1,nil,tc)
	if sg3:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.Attach(e,tc,sg3)
	end
	Duel.ConfirmCards(1-tp,sg2)
	Duel.SendtoDeck(sg2,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
end
