--Lass (Base Set 75/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--confirm hand, to deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
		or Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.todeck(tp)
	scard.todeck(1-tp)
end
function scard.tdfilter(c)
	return c:IsTrainer() and c:IsAbleToDeck()
end
function scard.todeck(tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g)
	local sg=g:Filter(scard.tdfilter,nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleHand(tp)
end
