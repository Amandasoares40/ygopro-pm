--Altar of the Sunne (Guardians Rising 118/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--no weakness
	aux.EnableEffectCustom(c,EFFECT_NO_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--no weakness
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_R+ENERGY_M)
