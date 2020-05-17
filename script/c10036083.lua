--Mom's Kindness (Majestic Dawn 83/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2))
end
scard.trainer_supporter=true
--[[
	Note: This card's effect is identical to that of "Bill".
]]
