--Lysandre (Flashfire 90/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),aux.SwitchOperation(PLAYER_SELF,PLAYER_OPPO))
end
scard.trainer_supporter=true
--[[
	Note: This card's effect is identical to that of "Gust of Wind".
]]
