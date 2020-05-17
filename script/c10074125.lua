--Tormenting Spray (Burning Shadows 125/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, discard hand
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_item=true
--confirm hand, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(tp,1)
	Duel.ConfirmCards(tp,sg)
	if sg:GetFirst():IsSupporter() then
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	end
	Duel.ShuffleHand(1-tp)
end
