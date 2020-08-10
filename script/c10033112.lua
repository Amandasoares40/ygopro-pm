--Lake Boundary (Mysterious Treasures 112/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--set weakness count
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_WEAKNESS_COUNT)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsHasWeakness))
	e1:SetValue(2)
	c:RegisterEffect(e1)
end
--[[
	Rulings
	Q. How does "Lake Boundary" affect Pokemon that have had their Weakness removed or reduced to zero?
	A. It only affects Pokemon that have Weakness, changing the modifier for that Weakness to x2 instead of whatever other
	modifier that Pokémon may have had. If the weakness has been reduced to zero, then zero times two is still zero.
	(Mysterious Treasures FAQ; Aug 23, 2007 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#182
]]
