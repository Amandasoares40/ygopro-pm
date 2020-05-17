--Blaine's Gamble (Gym Heroes 121/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE)
	--discard hand, draw
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(nil,LOCATION_HAND,0,1,c),scard.op1)
end
scard.trainer_item=true
--discard hand, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local hct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local ct=Duel.DiscardHand(tp,nil,1,hct,REASON_EFFECT+REASON_DISCARD)*2
	if hct==0 or ct==0 then return end
	Duel.BreakEffect()
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
