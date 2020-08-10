--Wishful Baton (Burning Shadows 128/147)
--UNCONFIRMED: Can I move 0 basic Energy cards from the Knocked Out Pokemon? (regarding "up to N")
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
	aux.AddAttachedDescription(c,DESC_WISHFUL_BATON_BUS128,aux.SelfActiveCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--gain effect
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c or c:GetFlagEffect(sid)>0 then return end
	--move energy
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
--move energy
function scard.regop2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup()
	g:KeepAlive()
	e:GetLabelObject():SetLabelObject(g)
end
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,nil,c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_ATTACK+REASON_DAMAGE) and c:IsPreviousActive() and c:GetFlagEffect(sid)>0
		and e:GetLabelObject():IsExists(scard.cfilter,1,nil,tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():Filter(scard.cfilter,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg1=g:Select(tp,1,3,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg2=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.MoveEnergy(sg2:GetFirst(),sg1)
end
