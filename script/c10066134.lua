--Brigette (BREAKthrough 134/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to bench)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--search (to bench)
function scard.tbfilter1(c,e,tp)
	return c:IsBasicPokemon() and c:IsPokemonEX() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tbfilter2(c,e,tp)
	return c:IsBasicPokemon() and not c:IsPokemonEX() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	local ct=Duel.GetFreeBenchCount(tp)
	if ct>3 then ct=3 end
	local g1=Duel.GetMatchingGroup(scard.tbfilter1,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(scard.tbfilter2,tp,LOCATION_DECK,0,nil,e,tp)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local sg1=g1:Select(tp,0,1,nil)
	if sg1:GetCount()>0 then
		if scard.tbfilter2(sg1:GetFirst(),e,tp) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
			local sg2=g2:Select(tp,0,ct-1,sg1)
			sg1:Merge(sg2)
		end
		Duel.PlayPokemon(sg1,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
	else
		Duel.ShuffleDeck(tp)
	end
end
