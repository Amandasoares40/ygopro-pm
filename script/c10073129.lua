--Multi Switch (Guardians Rising 129/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--move energy
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--move energy
function scard.cfilter(c,tp)
	return c:GetAttachedGroup():IsExists(scard.mefilter,1,nil,tp)
end
function scard.mefilter(c,tp)
	--local tc=Duel.GetActivePokemon(tp)
	return c:IsEnergy() --and tc and c:CheckAttachedTarget(tc)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetBenchedPokemon(tp):IsExists(scard.cfilter,1,nil,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetBenchedPokemon(tp):Filter(scard.cfilter,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.mefilter,1,1,nil,tp)
	Duel.MoveEnergy(Duel.GetActivePokemon(tp),sg2)
end
