--Fiery Flint (Dragon Majesty 60/70)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1,nil,aux.DiscardHandCost(2))
end
scard.trainer_item=true
--search (to hand)
function scard.thfilter(c)
	return c:IsEnergy(ENERGY_R) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,4,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. Can I play Fiery Flint if I only have 1 card in my hand to discard?
	A. No, you must be able to discard 2 cards in order to use Fiery Flint. (Sep 27, 2018 TPCi Rules Team)

	Q. Can I play Fiery Flint and discard two cards if there are no cards left in my deck?
	A. No, you cannot. Discarding the two cards is a cost not the effect, and you cannot play Trainer cards for no effect.
	(Mar 21, 2019 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#613
]]
