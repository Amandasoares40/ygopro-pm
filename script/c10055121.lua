--Ether (Plasma Storm 121/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--attach
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--attach
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetInPlayPokemon(tp):GetCount()>0 end
end
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(scard.cfilter,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
	local sg=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,g:GetFirst())
	Duel.HintSelection(sg)
	Duel.DisableShuffleCheck()
	Duel.Attach(e,sg:GetFirst(),g)
end
