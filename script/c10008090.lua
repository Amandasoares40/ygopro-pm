--Time Capsule (Neo Genesis 90/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, gain effect
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter,LOCATION_DPILE,LOCATION_DPILE),scard.op1)
end
scard.trainer_item=true
--to deck, gain effect
function scard.tdfilter(c)
	return (c:IsPokemon() or c:IsBasicEnergy()) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.todeck(1-tp)
	scard.todeck(tp)
	--cannot play trainer
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(DESC_PLAYER_CANNOT_PLAY_TRAINER)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,0)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.todeck(tp)
	local g=Duel.GetMatchingGroup(scard.tdfilter,tp,LOCATION_DPILE,0,nil)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_TODECK) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,5,5,nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
end
--cannot play trainer
function scard.val1(e,re,tp)
	return re:IsActiveType(TYPE_TRAINER)
end
