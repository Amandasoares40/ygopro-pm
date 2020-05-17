--Pokemon Circulator (Unleashed 81/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),aux.SwitchOperation(PLAYER_OPPO,PLAYER_OPPO))
end
scard.trainer_item=true
--[[
	Rulings
		Q. Can I play "Pokemon Circulator" if my opponent doesn't have any benched Pokemon?
		A. Since Pokemon Circulator requires your opponent to switch with a benched Pokemon, you can't play it unless your
		opponent has a Pokemon on the bench. (HS:Unleashed FAQ; May 13, 2010 PUI Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#162
]]
