--Pokemon Contest Hall (Rising Rivals 93/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--search (to bench, attach)
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
--search (to bench, attach)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.atfilter(c,tc)
	return c:IsPokemonTool() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp):GetFirst()
	if tc then
		if Duel.PlayPokemon(tc,0,tp,tp,true,false,POS_FACEUP_UPSIDE)>0 and tc:IsCanAttachPokemonTool() then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHTRAINER)
			local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DECK,0,0,1,nil,tc)
			if g:GetCount()>0 then
				Duel.Attach(e,tc,g)
			else
				Duel.ShuffleDeck(tp)
			end
		end
	else
		Duel.ShuffleDeck(tp)
	end
end
