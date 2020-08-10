--Trick Coin (Phantom Forces 108/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--re-flip coin
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TOSS_COIN_NEGATE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_NEGATE_COIN_ATTACK)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--re-flip coin
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFlagEffect(tp,sid)==0 and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,sid)>0 or not Duel.SelectYesNo(tp,aux.Stringid(sid,0)) then return end
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	Duel.RegisterFlagEffect(tp,sid,RESET_PHASE+PHASE_END,0,1)
	Duel.TossCoin(tp,ev)
end
--[[
	Note: This card's effect is similar to that of "Sabrina's ESP".
]]
