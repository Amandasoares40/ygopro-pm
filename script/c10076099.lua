--Sea of Nothingness (Crimson Invasion 99/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--do not remove special conditions
	aux.EnableEffectCustom(c,EFFECT_DONOT_REMOVE_SPC_EVOLVE_DEVOLVE,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY)
end
