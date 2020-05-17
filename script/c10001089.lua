--Revive (Base Set 89/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to bench
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--to bench
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp)
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_DPILE,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DPILE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.PlayPokemon(g,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
	end
end
