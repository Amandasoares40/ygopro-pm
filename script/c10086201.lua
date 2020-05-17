--Professor Oak's Setup (Cosmic Eclipse 201/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to bench)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--search (to bench)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	local ct=Duel.GetFreeBenchCount(tp)
	if ct>3 then ct=3 end
	local g=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local sg=aux.SelectUnselectGroup(g,e,tp,0,ct,aux.EnergyTypeClassCheck,1,tp,HINTMSG_TOBENCH)
	if sg:GetCount()>0 then
		Duel.PlayPokemon(sg,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
	else
		Duel.ShuffleDeck(tp)
	end
end
