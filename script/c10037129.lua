--Bubble Coat (Legends Awakened 129/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS)
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS)
	--discard self
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabelObject(c)
	e1:SetCondition(scard.regcon1)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,0))
	e2:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetLabelObject(c)
	e2:SetCondition(scard.con1)
	e2:SetOperation(scard.op1)
	c:RegisterEffect(e2)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--discard self
function scard.regcon1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetFlagEffect(sid)>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
end
