--Lass's Special (Fates Collide 103/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.GetBenchedPokemon(1-tp):GetCount()>0 end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,Duel.GetBenchedPokemon(1-tp):GetCount(),REASON_EFFECT)
end
