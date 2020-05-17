--Mallow (Guardians Rising 127/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (sort deck)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--search (sort deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if g:GetCount()<=0 then return end
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
		local sg=g:Select(tp,2,2,nil)
		Duel.ShuffleDeck(tp)
		for tc in aux.Next(sg) do
			Duel.MoveSequence(tc,SEQ_DECK_TOP)
		end
		Duel.SortDecktop(tp,tp,2)
	elseif g:GetCount()==1 then
		Duel.ConfirmCards(tp,g)
	end
end
