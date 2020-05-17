--Gym Badge (Black Star Promo XY203)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then ct=ct+1 end
	until res==RESULT_TAILS
	Duel.Draw(tp,ct,REASON_EFFECT)
end
