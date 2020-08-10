--Pokemon Collector (HeartGold & SoulSilver 97/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--search (to hand)
function scard.thfilter(c)
	return c:IsBasicPokemon() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. Can I use "Pokemon Collector" to choose Pokemon LEGEND cards as part of the 3 Basic Pokemon I search for in my
	deck?
	A. No, because Pokemon Collector only lets you choose Basic Pokemon. Pokemon LEGEND are considered "Unevolved Pokemon"
	when in play, but they are not considered "Basic Pokemon".
	(GS:Heart Gold/Soul Silver FAQ; Feb 11, 2010 PUI Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#163

	Note: This card's effect is similar to that of "Pokemon Collector".
]]
