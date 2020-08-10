--Focus Band (Neo Genesis 86/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--knock out replace (gain effect)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_KNOCK_OUT_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetLabelObject(c)
	e1:SetTarget(scard.tg1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_DONOT_KO)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--knock out replace (gain effect)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsReason(REASON_ATTACK+REASON_DAMAGE)
		and c:GetReasonPlayer()==1-tp end
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		--set remaining hp
		aux.AddTempEffectSetRemHP(c,c,10)
		Duel.BreakEffect()
		Duel.SendtoDPile(tc,REASON_EFFECT+REASON_DISCARD)
		return true
	else return false end
end
