--Spell Tag (Lost Thunder 190/214)
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
	aux.AddAttachedDescription(c,DESC_SPELL_TAG_LOT190,aux.SelfEnergyTypeCondition(ENERGY_P))
end
scard.trainer_item=TYPE_POKEMON_TOOL
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
	return rp==1-tp and c:IsReason(REASON_ATTACK+REASON_DAMAGE)
		and c:IsEnergyType(ENERGY_P) and c:GetFlagEffect(sid)>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(1-tp)
	if g:GetCount()==0 then return end
	local count=4
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDCOUNTER)
		local sg=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		local t={}
		for i=1,count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCECOUNTER)
		local damc=Duel.AnnounceNumber(tp,table.unpack(t))
		sg:GetFirst():AddCounter(tp,COUNTER_DAMAGE,damc,REASON_EFFECT)
		g:Sub(sg)
		count=count-damc
	until count==0 or g:GetCount()==0
end
