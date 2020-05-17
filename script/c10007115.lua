--Koga's Ninja Trick (Gym Challenge 115/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_KOGA)
	--attach trainer
	aux.EnableAttachTrainer(c,scard.trainfilter)
	--discard self
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabelObject(c)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--switch
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,0))
	e2:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_ACTIVE)
	e2:SetLabelObject(c)
	e2:SetCondition(scard.con1)
	e2:SetOperation(scard.op2)
	c:RegisterEffect(e2)
	aux.AddAttachedDescription(c,DESC_KOGAS_NINJA_TRICK_G2115)
end
scard.trainer_item=true
--attach trainer
function scard.trainfilter(c)
	return c:IsActive() and c:IsSetCard(SETNAME_KOGA)
end
--discard self
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c and c:IsBenched() then
		Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
	end
end
--switch
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-Duel.GetTurnPlayer())
	return tc and tc==e:GetHandler() and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetLabelObject():GetOriginalCode())
	Duel.SwitchPokemon(tp,tp)
end
