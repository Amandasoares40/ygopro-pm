--Warp Point (Gym Challenge 126/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_ALL),scard.op1)
end
scard.trainer_item=true
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SwitchPokemon(1-tp,1-tp)
	Duel.SwitchPokemon(tp,tp)
end
--[[
	Note: This card's effect is similar to that of "Double Gust".
]]
