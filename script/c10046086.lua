--Indigo Plateau (Triumphant 86/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain hp
	aux.EnableUpdateHP(c,30,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--gain hp
scard.tg1=aux.TargetBoolFunction(Card.IsPokemonLEGEND)
