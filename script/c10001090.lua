--Super Potion (Base Set 90/102)
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
	if Duel.HealDamage(tp,g,60,REASON_EFFECT) then
		Duel.DiscardAttached(tp,g,Card.IsEnergy,1,1,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. What happens if you play Super Potion for a Pokemon that doesn't have any energy cards attached to it?
	A. You still remove 60 damage (or as much as you can), but that's all. (XY FAQ; Feb 6, 2014 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#343
]]
