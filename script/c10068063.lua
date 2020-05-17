--Imakuni? (Generations 63/83)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confused
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--confused
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(tp)
	if chk==0 then return tc and tc:IsCanBeConfused() end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(tp):ApplySpecialCondition(tp,SPC_CONFUSED)
end
