--Heal Powder (Neo Destiny 104/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove all special conditions, remove counter
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--remove all special conditions, remove counter
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(tp)
	if chk==0 then return tc and (tc:IsAffectedBySpecialCondition() or tc:IsDamaged()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local tc=Duel.GetActivePokemon(tp)
	tc:RemoveSpecialCondition(tp,SPC_ALL)
	tc:RemoveCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
end
