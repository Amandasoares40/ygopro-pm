--Holon Scientist (Delta Species 97/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,nil,aux.DiscardHandCost(1))
end
scard.trainer_supporter=true
--draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. Can you play Holon Scientist if you will not be able to draw any cards?
	A. No, you must be able to draw at least one card after you have paid the discard cost. (Jan 4, 2007 PUI Rules Team)
	https://compendium.pokegym.net/compendium-ex.html#trainers
]]
