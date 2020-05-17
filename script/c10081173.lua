--Faba (Lost Thunder 173/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to lost zone
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--to lost zone
function scard.tlfilter1(c)
	return c:IsFaceup() and c:IsStadium() and c:IsAbleToLost()
end
function scard.cfilter1(c)
	return c:GetAttachedGroup():IsExists(scard.tlfilter2,1,nil)
end
function scard.tlfilter2(c)
	return c:IsPokemonTool() and c:IsAbleToLost()
end
function scard.cfilter2(c)
	return c:GetAttachedGroup():IsExists(scard.tlfilter3,1,nil)
end
function scard.tlfilter3(c)
	return c:IsSpecialEnergy() and c:IsAbleToLost()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.tlfilter1,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil)
		or Duel.IsExistingMatchingCard(scard.cfilter1,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil)
		or Duel.IsExistingMatchingCard(scard.cfilter2,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.tlfilter1,tp,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	local g2=Duel.GetAttachedGroup(tp,0,1):Filter(scard.tlfilter2,nil)
	local g3=Duel.GetAttachedGroup(tp,0,1):Filter(scard.tlfilter3,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOLZONE)
	local sg=g1:Select(tp,1,1,nil)
	if sg:GetCount()==0 then return end
	Duel.HintSelection(sg)
	Duel.SendtoLost(sg,REASON_EFFECT)
end
