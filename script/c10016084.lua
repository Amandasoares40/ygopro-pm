--Lum Berry (Ruby & Sapphire 84/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--remove all special conditions
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabelObject(c)
	e1:SetCondition(aux.AffectedBySpecialCondition)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_REMOVE_SPC_SELF_EOT,aux.AffectedBySpecialCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--remove all special conditions
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveSpecialCondition(tp,SPC_ALL)
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
end
