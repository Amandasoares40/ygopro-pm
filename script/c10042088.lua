--Lucky Egg (Arceus 88/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_LUCKY_EGG_AR88)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--gain effect
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c or c:GetFlagEffect(sid)>0 then return end
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_KNOCKED_OUT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD+RESET_ATTACH)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESET_TOFIELD+RESET_ATTACH,0,1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	return ct>0 and rp==1-tp and c:IsReason(REASON_ATTACK+REASON_DAMAGE) and c:GetFlagEffect(sid)>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
