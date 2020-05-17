--Lana (Burning Shadows 117/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_supporter=true
--heal
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon()
		and c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil,ENERGY_W) and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.healfilter,tp,LOCATION_INPLAY,0,nil)
	Duel.HealDamage(tp,g,50,REASON_EFFECT)
end
