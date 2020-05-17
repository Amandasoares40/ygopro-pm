--Pokemon Catcher (Sun & Moon 126/149) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),scard.op1)
end
scard.trainer_item=true
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.SwitchPokemon(tp,1-tp)
	end
end
--[[
	Note: This card's effect is identical to that of "Pokemon Reversal".
]]
