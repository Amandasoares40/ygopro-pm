--Cheerleader's Cheer (Unleashed 71/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.OR(aux.DrawTarget(PLAYER_SELF),aux.DrawTarget(PLAYER_OPPO)),scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	if Duel.IsPlayerCanDraw(1-tp,1) and Duel.SelectYesNo(1-tp,YESNOMSG_DRAW) then
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end
--[[
	Note: This card's effect is identical to that of "Fieldworker".
]]
