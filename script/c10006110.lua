--Erika's Perfume (Gym Heroes 110/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ERIKA)
	--confirm hand, to bench
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_item=true
--confirm hand, to bench
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	local tg=g:Filter(scard.tbfilter,nil,e,tp)
	if Duel.IsNotBenchFull(1-tp) and tg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
		local sg=tg:Select(tp,1,Duel.GetFreeBenchCount(1-tp),nil)
		Duel.PlayPokemon(sg,0,tp,1-tp,true,false,POS_FACEUP_UPSIDE)
	end
	Duel.ShuffleHand(1-tp)
end
