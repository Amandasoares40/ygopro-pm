--Amulet Coin (Great Encounters 97/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.AND(aux.SelfActiveCondition,aux.TurnPlayerCondition))
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(aux.DrawOperation(PLAYER_SELF,1))
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_AMULET_COIN_GE97,aux.AND(aux.SelfActiveCondition,aux.TurnPlayerCondition))
end
scard.trainer_item=TYPE_POKEMON_TOOL
