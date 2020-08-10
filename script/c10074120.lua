--Plumeria (Burning Shadows 120/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.defilter,0,LOCATION_INPLAY),scard.op1,nil,aux.DiscardHandCost(2))
end
scard.trainer_supporter=true
--discard energy
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local g=Duel.SelectMatchingCard(tp,scard.defilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.DiscardAttached(tp,g,Card.IsEnergy,1,1,REASON_EFFECT)
end
--[[
	Rulings
	Q. Can I play Plumeria and discard two cards if my if my opponent has no energy attached to any of their Pokemon?
	A. No, you cannot. Discarding the two cards is a cost not the effect, and you cannot play Trainer cards for no effect.
	(Mar 21, 2019 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#653
]]
