--Energy Pouch (Fates Collide 97/124)
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
	aux.AddAttachedDescription(c,DESC_ENERGY_POUCH_FCO97)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--gain effect
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c or c:GetFlagEffect(sid)>0 then return end
	--return
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
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetOperation(scard.regop2)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_EVENT+RESET_TOFIELD+RESET_ATTACH)
	c:RegisterEffect(e2)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESET_TOFIELD+RESET_ATTACH,0,1)
end
--return
function scard.regop2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup()
	g:KeepAlive()
	e:GetLabelObject():SetLabelObject(g)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_ATTACK+REASON_DAMAGE) and c:GetFlagEffect(sid)>0
		and e:GetLabelObject():IsExists(scard.retfilter,1,nil)
end
function scard.retfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():Filter(scard.retfilter,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
