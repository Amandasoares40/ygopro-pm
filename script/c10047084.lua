--Research Record (Call of Legends 84/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--sort deck
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--sort deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if dct<=0 then return end
	if dct>4 then dct=4 end
	local g=Duel.GetDecktopGroup(tp,dct)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
	local sg1=g:Select(tp,0,dct,nil)
	local ct1=sg1:GetCount()
	for tc1 in aux.Next(sg1) do
		Duel.MoveSequence(tc1,SEQ_DECK_TOP)
	end
	if ct1>1 then
		Duel.SortDecktop(tp,tp,ct1)
	end
	g:Sub(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKBOT)
	local sg2=g:Select(tp,dct-ct1,dct-ct1,nil)
	local ct2=sg2:GetCount()
	for tc2 in aux.Next(sg2) do
		Duel.MoveSequence(tc2,SEQ_DECK_TOP)
	end
	if ct2>1 then
		Duel.SortDecktop(tp,tp,ct2)
	end
	for i=1,ct2 do
		local mg=Duel.GetDecktopGroup(tp,ct2)
		Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
	end
end
