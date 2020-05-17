--Pokedex (Base Set 87/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--sort deck
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--sort deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,5)
end
