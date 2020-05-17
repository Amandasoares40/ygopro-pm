--Rocket's Minefield Gym (Gym Challenge 119/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS)
	--stadium
	aux.EnableStadiumAttribute(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--add counter
function scard.cfilter(c)
	return c:IsBasicPokemon() and c:IsPlayedFromHand()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(aux.BenchedPokemonFilter(scard.cfilter),nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()==1
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if e:GetHandler():IsRelateToEffect(e) and Duel.TossCoin(tp,1)==RESULT_TAILS then
		g:GetFirst():AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
