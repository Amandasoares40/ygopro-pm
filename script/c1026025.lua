--Team Aqua Admin (Double Crisis 25/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA)
	--attach
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--attach
function scard.atfilter(c,tc)
	return c:IsBasicEnergy() and c:CheckAttachedTarget(tc)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(tp)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.atfilter,tp,LOCATION_DPILE,0,1,nil,tc)
		and tc:IsSetCard(SETNAME_TEAM_AQUA) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DPILE,0,1,1,nil,tc)
	if g:GetCount()>0 then
		Duel.Attach(e,tc,g)
	end
end
