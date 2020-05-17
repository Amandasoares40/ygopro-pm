--Wela Volcano Park (Dragon Majesty 63/70)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--do not remove burned
	aux.EnablePlayerEffectCustom(c,EFFECT_DONOT_REMOVE_BURNED_HEADS,LOCATION_STADIUM,1,1)
end
