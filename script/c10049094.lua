--Max Potion (Emerging Powers 94/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal, discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--heal, discard energy
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_HEAL)
	local g=Duel.SelectMatchingCard(tp,scard.healfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local tc=g:GetFirst()
	if not Duel.HealDamage(tp,tc,tc:GetDamage(),REASON_EFFECT) then return end
	local ag=tc:GetAttachedGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(ag,REASON_EFFECT+REASON_DISCARD)
end
--[[
	Rulings
	Q. Can you use Max Potion to heal a Pokemon that doesn't have any energy attached to it?
	A. Yes, you can. (BW:Emerging Powers FAQ; Sep 1, 2011 PUI Rules Team)

	Q. Can you use Max Potion on a Pokemon with Energies attached but no damage on it?
	A. No, you cannot. If you don't have any damage, you cannot use Max Potion on that Pokemon.
	(Feb 16, 2012 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#210
]]
