--Oracle (Skyridge 138/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (sort deck)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--search (sort deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local ct=g:GetCount()
	if ct<=0 then return end
	if ct>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
		local sg=g:Select(tp,2,2,nil)
		Duel.ShuffleDeck(tp)
		for tc in aux.Next(sg) do
			Duel.MoveSequence(tc,SEQ_DECK_TOP)
		end
		Duel.SortDecktop(tp,tp,2)
	elseif ct==1 then
		Duel.ConfirmCards(tp,g)
	end
end
