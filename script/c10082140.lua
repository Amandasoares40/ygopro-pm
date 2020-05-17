--Erika's Hospitality (Team Up 140/181)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ERIKA)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,scard.con1)
end
scard.trainer_supporter=true
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<=4
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetInPlayPokemon(1-tp):GetCount()
	if ct>0 then
		Duel.Draw(tp,1*ct,REASON_EFFECT)
	end
end
