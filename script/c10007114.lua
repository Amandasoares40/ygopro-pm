--Fuchsia City Gym (Gym Challenge 114/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckCardFunction(scard.tdfilter,LOCATION_INPLAY,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--to deck
function scard.tdfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(SETNAME_KOGA) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	if not Duel.SelectYesNo(tp,YESNOMSG_TODECK) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:Merge(g:GetFirst():GetAttachedGroup())
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
