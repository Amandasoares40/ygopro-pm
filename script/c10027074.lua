--Full Flame (Legend Maker 74/92)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--replace burned damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REPLACE_BURNED_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(1,1)
	e1:SetValue(4)
	c:RegisterEffect(e1)
	--do not remove burned
	aux.EnablePlayerEffectCustom(c,EFFECT_DONOT_REMOVE_BURNED_EVOLVE_DEVOLVE,LOCATION_STADIUM,1,1)
end
