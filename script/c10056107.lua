--Life Dew (Plasma Freeze 107/116)
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
	aux.AddAttachedDescription(c,DESC_REDUCE_PRIZE_FROM_KO)
end
scard.trainer_item=TYPE_POKEMON_TOOL
scard.trainer_ace_spec=true
--gain effect
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c or c:GetFlagEffect(sid)>0 then return end
	--reduce prize
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DEFEND_UPDATE_PRIZE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(-1)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD+RESET_ATTACH)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESET_TOFIELD+RESET_ATTACH,0,1)
end
