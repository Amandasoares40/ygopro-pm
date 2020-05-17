--Dark Patch (Dark Explorers 93/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--attach
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--attach
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and c:IsEnergy(ENERGY_D)
		and Duel.GetBenchedPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return c:IsEnergyType(ENERGY_D) and tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_DPILE,0,1,nil,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DPILE,0,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
	local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.Attach(e,sg2:GetFirst(),sg1)
end
