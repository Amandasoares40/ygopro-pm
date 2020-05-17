--Fast Ball (Expedition 124/165)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BALL)
	--confirm deck (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--confirm deck (to hand)
function scard.thfilter(c)
	return c:IsEvolution() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct<=0 then return end
	local seq=-1
	local thcard=nil
	for tc in aux.Next(g) do
		if tc:GetSequence()>seq then
			seq=tc:GetSequence()
			thcard=tc
		end
	end
	if seq==-1 then
		Duel.ConfirmDecktop(tp,ct)
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOTARGETS)
		Duel.ShuffleDeck(tp)
		return
	end
	Duel.ConfirmDecktop(tp,ct-seq)
	if thcard:IsAbleToHand() then
		Duel.SendtoHand(thcard,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,thcard)
	else
		Duel.ShuffleDeck(tp)
	end
end
