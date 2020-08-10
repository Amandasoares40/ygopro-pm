--Training Center (Furious Fists 102/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain hp
	aux.EnableUpdateHP(c,30,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--gain hp
function scard.tg1(e,c)
	return c:IsStage1() or c:IsStage2()
end
--[[
	Note: This card's effect is similar to that of "Indigo Plateau".
]]
