--Alph Lithograph (HeartGold & SoulSilver ONE/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_item=true
--confirm hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,g)
	Duel.ShuffleHand(1-tp)
end
