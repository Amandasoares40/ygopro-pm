--Coach Trainer (Unified Minds 192/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local tc=Duel.GetActivePokemon(tp)
	if tc and tc:IsTAGTEAM() then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
