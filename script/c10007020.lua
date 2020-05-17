--Sabrina (Gym Challenge 110/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_SABRINA)
	--attach
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--attach
function scard.cfilter1(c,tp)
	return c:IsSetCard(SETNAME_SABRINA) and c:GetAttachedGroup():IsExists(scard.cfilter2,1,nil)
end
function scard.cfilter2(c,tp)
	return c:IsEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,c:GetAttachedTarget(),c)
end
function scard.mefilter(c,tc)
	return c:IsSetCard(SETNAME_SABRINA) and tc:CheckAttachedTarget(c)
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
	local ag=sg1:GetFirst():GetAttachedGroup():Filter(scard.cfilter2,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg2=g:Select(tp,1,1,sg1)
	Duel.HintSelection(sg2)
	Duel.Attach(e,sg2:GetFirst(),ag)
end
