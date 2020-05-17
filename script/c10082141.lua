--Evelyn (Team Up 141/181)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,4),scard.con1)
end
scard.trainer_supporter=true
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	return tc and tc:IsStage1()
end
