--Caitlin (Plasma Blast 78/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToDeck,LOCATION_HAND,0,1,c),scard.op1)
end
scard.trainer_supporter=true
--to deck, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,ct,nil)
	if g:GetCount()==0 or Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)==0 then return end
	local dct=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if dct>1 then
		Duel.SortDecktop(tp,tp,dct)
	end
	for i=1,dct do
		local mg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,dct,REASON_EFFECT)
end
