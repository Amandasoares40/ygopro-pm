--Curse Powder (Unseen Forces 80/115)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,scard.toolfilter)
	--gain effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_DAMAGE_FROM_KO,scard.con2)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--pokemon tool
function scard.toolfilter(c)
	return c:IsEvolved() and not c:IsPokemonex()
end
--gain effect
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c or c:GetFlagEffect(sid)>0 then return end
	--add counter
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
--add counter
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_ATTACK+REASON_DAMAGE) and c:IsPreviousActive() and c:GetFlagEffect(sid)>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(1-tp):AddCounter(tp,COUNTER_DAMAGE,3,REASON_EFFECT)
end
function scard.con2(e)
	local c=e:GetHandler()
	return c:IsActive() and scard.toolfilter(c)
end
