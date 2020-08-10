--First Ticket (Dragon Vault 19/20)
--Note: Can't be used after rule change: https://compendium.pokegym.net/compendium-bw.html#271
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_PRE_GAME_START)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
--
function scard.con1(e)
	return Duel.IsFirstTurn() and e:GetHandler():IsLocation(LOCATION_HAND)
		and Duel.GetFlagEffect(e:GetHandlerPlayer(),sid)==0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	if not te or not te:IsActivatable(tp) or not Duel.SelectYesNo(tp,aux.Stringid(sid,0)) then return end
	e:SetType(EFFECT_TYPE_ACTIVATE)
	Duel.MoveToField(c,tp,tp,LOCATION_TEMPORARY,POS_FACEUP,true)
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	c:CreateEffectRelation(e)
	if Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(1-tp,sid)==0 then
		Duel.EndTurn()
	end
	c:ReleaseEffectRelation(e)
	Duel.RegisterFlagEffect(tp,sid,RESET_PHASE+PHASE_DRAW,0,1)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND+LOCATION_DECK,0,nil,c:GetOriginalCode())
	g:AddCard(c)
	Duel.SendtoDPile(g,REASON_RULE+REASON_DISCARD)
end
