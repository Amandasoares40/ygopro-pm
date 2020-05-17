--Lt. Surge (Gym Heroes 17/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_LT_SURGE)
	--switch
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--switch
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsBasicPokemon,tp,LOCATION_HAND,0,1,nil)
		and Duel.GetActivePokemon(tp) and Duel.IsNotBenchFull(tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsBasicPokemon,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local seq=Duel.SelectBenchZone(tp)
	Duel.MoveSequence(Duel.GetActivePokemon(tp),seq)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PROMOTE)
	local sg=g:Select(tp,1,1,nil)
	Duel.MoveToField(sg:GetFirst(),tp,tp,LOCATION_BENCH,POS_FACEUP_UPSIDE,true,ZONE_MZONE_EX_LEFT)
end
