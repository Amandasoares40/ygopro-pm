--Focus Sash (Furious Fists 91/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--check for full hp
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_ADJUST)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetOperation(scard.regop1)
	c:RegisterEffect(e0)
	--knock out replace (gain effect)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_KNOCK_OUT_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetLabelObject(c)
	e1:SetTarget(scard.tg1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_DONOT_KO,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--check for full hp
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsDamaged() and c:GetFlagEffect(sid)==0 then
		c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
	end
	if c:IsDamaged() and c:GetFlagEffect(sid)>0 then
		c:ResetFlagEffect(sid)
	end
end
--knock out replace (gain effect)
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsEnergyType(ENERGY_F) and c:GetFlagEffect(sid)>0
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsReason(REASON_ATTACK+REASON_DAMAGE)
		and c:GetReasonPlayer()==1-tp end
	if c:IsEnergyType(ENERGY_F) and c:GetFlagEffect(sid)>0 then
		local tc=e:GetLabelObject()
		Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
		--set remaining hp
		aux.AddTempEffectSetRemHP(c,c,10)
		Duel.BreakEffect()
		Duel.SendtoDPile(tc,REASON_EFFECT+REASON_DISCARD)
		c:ResetFlagEffect(sid)
		return true
	else return false end
end
