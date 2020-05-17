--Full Heal (Base Set 82/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--remove all special conditions
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--remove all special conditions
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivePokemon(tp):IsAffectedBySpecialCondition() end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(tp):RemoveSpecialCondition(tp,SPC_ALL)
end
