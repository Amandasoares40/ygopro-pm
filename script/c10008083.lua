--Arcade Game (Neo Genesis 83/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
scard.trainer_goldenrod_game_corner=true
--to hand
function scard.thfilter1(c,g)
	return g:IsExists(scard.thfilter2,1,c,c:GetCode())
end
function scard.thfilter2(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.ShuffleDeck(tp)
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	local sg=g:Filter(scard.thfilter1,nil,g)
	if sg:GetCount()>0 then
		if sg:GetCount()==3 then Duel.DisableShuffleCheck() end
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
