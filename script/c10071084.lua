--Professor Oak's Hint (Evolutions 84/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, end turn
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--draw, end turn
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=7-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct>0 and Duel.Draw(tp,ct,REASON_EFFECT)>0 then
		Duel.EndTurn()
	end
end
--[[
	Note: This card's effect is almost identical to that of "Tropical Beach".
]]
