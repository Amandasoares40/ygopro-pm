--Gold Berry (Neo Genesis 93/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--remove counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabelObject(c)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(sid,1))
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	c:RegisterEffect(e2)
	aux.AddAttachedDescription(c,DESC_REMOVE_COUNTER_SELF_EOT,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--remove counter
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(COUNTER_DAMAGE)>=4
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsCanRemoveCounter(tp,COUNTER_DAMAGE,4,REASON_EFFECT) and Duel.SelectYesNo(tp,YESNOMSG_REMOVECOUNTER) then
		c:RemoveCounter(tp,COUNTER_DAMAGE,4,REASON_EFFECT)
	end
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
end
