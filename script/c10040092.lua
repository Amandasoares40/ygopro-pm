--Lucian's Assignment (Rising Rivals 92/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--move energy
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--move energy
function scard.cfilter1(c,tp)
	return c:GetAttachedGroup():IsExists(scard.cfilter2,1,nil,tp)
end
function scard.cfilter2(c,tp)
	return c:IsEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,c:GetAttachedTarget(),c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter1,1,nil,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(tp):Filter(scard.cfilter1,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	local ag=sg1:GetFirst():GetAttachedGroup()
	local ct=ag:FilterCount(scard.cfilter2,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg2=ag:FilterSelect(tp,scard.cfilter2,1,ct,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg3=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,sg1,sg2:GetFirst())
	Duel.HintSelection(sg3)
	Duel.MoveEnergy(sg3:GetFirst(),sg2)
end
