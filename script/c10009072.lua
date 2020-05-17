--Fossil Egg (Neo Discovery 72/75)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--search (to bench)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--search (to bench)
function scard.tbfilter(c,e,tp)
	return aux.IsEvolutionChain(c,CARD_MYSTERIOUS_FOSSIL)
		and not c:IsCode(CARD_MYSTERIOUS_FOSSIL) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and (Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		or Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND,0,1,nil,e,tp)) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0
		or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND+LOCATION_DECK,0,0,1,nil,e,tp):GetFirst()
	if tc and Duel.PlayPokemonStep(tc,0,tp,tp,true,false,POS_FACEUP_UPSIDE) then
		--treat as basic pokemon
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(DESC_BASIC_POKEMON)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(TYPE_BASIC_POKEMON)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		tc:RegisterEffect(e1,true)
		Duel.PlayPokemonComplete()
	else
		Duel.ShuffleDeck(tp)
	end
end
