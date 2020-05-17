--Repel (Sun & Moon 130/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),aux.SwitchOperation(PLAYER_OPPO,PLAYER_OPPO))
end
scard.trainer_item=true
--[[
	Note: This card's effect is identical to that of "Pokemon Circulator".
]]
