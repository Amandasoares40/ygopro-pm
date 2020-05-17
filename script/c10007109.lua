--Resistance Gym (Gym Challenge 109/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce resistance count
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_RESISTANCE_COUNT)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsHasResistance))
	e1:SetValue(-20)
	c:RegisterEffect(e1)
end
