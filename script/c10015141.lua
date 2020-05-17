--Underground Lake (Skyridge 141/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--to bench
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--to bench
function scard.tbfilter(c,e,tp)
	return c:IsCode(CARD_OMANYTE,CARD_KABUTO) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp)
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_DPILE,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.IsBenchFull(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DPILE,0,1,1,nil,e,tp):GetFirst()
	if not tc or not Duel.PlayPokemonStep(tc,0,tp,tp,true,false,POS_FACEUP_UPSIDE) then return end
	--treat as basic pokemon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BASIC_POKEMON)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(TYPE_BASIC_POKEMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
	tc:RegisterEffect(e1,true)
	Duel.PlayPokemonComplete()
end
