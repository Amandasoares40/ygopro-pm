--Steven's Advice (Hidden Legends 92/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,scard.con1)
end
scard.trainer_supporter=true
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<7
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetInPlayPokemon(1-tp):GetCount()
	Duel.DrawUpTo(tp,ct,REASON_EFFECT,true)
end
