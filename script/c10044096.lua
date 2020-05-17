--Alph Lithograph (Unleashed TWO/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--shuffle deck
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--shuffle deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.ShuffleDeck(tp)
end
