--Team Rocket's Handiwork (Fates Collide 112/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS)
	--discard deck
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_supporter=true
--discard deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)<=0 then return end
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	Duel.DiscardDeck(1-tp,ct*2,REASON_EFFECT)
end
