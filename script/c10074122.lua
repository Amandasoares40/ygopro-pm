--Rotom Dex Poke Finder Mode (Burning Shadows 122/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROTOM)
	--confirm deck (sort deck or shuffle deck)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--confirm deck (sort deck or shuffle deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,4)
	Duel.ConfirmCards(tp,g)
	if g:GetCount()==1 then return end
	if Duel.SelectYesNo(tp,YESNOMSG_SHUFFLEDECK) then
		Duel.ShuffleDeck(tp)
	else
		Duel.SortDecktop(tp,tp,4)
	end
end
