--Psychic's Third Eye (BREAKpoint 108/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, discard hand, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--confirm hand, discard hand, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		or (Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler()) and Duel.IsPlayerCanDraw(tp,1)) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,g)
	Duel.ShuffleHand(1-tp)
	local hct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if hct==0 or not Duel.SelectYesNo(tp,YESNOMSG_DISCARDHAND) then return end
	Duel.BreakEffect()
	local ct=Duel.DiscardHand(tp,nil,1,hct,REASON_EFFECT+REASON_DISCARD)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
--[[
	Note: This card's effect is identical to that of "Secret Mission".
]]
