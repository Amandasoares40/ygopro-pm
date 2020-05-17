--Maxie (Team Magma vs Team Aqua 73/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to bench
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--to bench
function scard.tbfilter(c,e,tp)
	return c:IsPokemon() and c:IsSetCard(SETNAME_TEAM_MAGMA) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp)
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND+LOCATION_DPILE,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND+LOCATION_DPILE,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.PlayPokemonStep(tc,0,tp,tp,true,false,POS_FACEUP_UPSIDE) then
		if tc:IsStage2() then
			tc:AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
		end
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
