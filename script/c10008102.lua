--Pokemon March (Neo Genesis 102/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to bench)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--search (to bench)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.IsNotBenchFull(1-tp) and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0)
		or (Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.tobench(e,1-tp)
	Duel.BreakEffect()
	scard.tobench(e,tp)
end
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tobench(e,tp)
	if Duel.IsBenchFull(tp) or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0
		or not Duel.SelectYesNo(tp,YESNOMSG_SEARCH) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.PlayPokemon(g,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
	else
		Duel.ShuffleDeck(tp)
	end
end
