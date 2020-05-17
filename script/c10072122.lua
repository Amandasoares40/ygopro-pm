--Lillie (Sun & Moon 122/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.IsFirstTurn(tp) and 8 or 6
	local dct=ct-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return dct>0 and Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.IsFirstTurn(tp) and 8 or 6
	local dct=ct-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if dct>0 then
		Duel.Draw(tp,dct,REASON_EFFECT)
	end
end
