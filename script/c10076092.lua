--Dashing Pouch (Crimson Invasion 92/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--redirect (return)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TO_DPILE_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetTargetRange(LOCATION_ALL,0)
	e1:SetCondition(aux.SelfActiveCondition)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsReason,REASON_RETREAT))
	e1:SetValue(LOCATION_HAND)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_DASHING_POUCH_CIN92)
end
scard.trainer_item=TYPE_POKEMON_TOOL
