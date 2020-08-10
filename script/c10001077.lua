--Pokemon Trader (Base Set 77/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1,nil,aux.SendtoDeckCost(scard.costfilter,LOCATION_HAND,1))
end
scard.trainer_item=true
--search (to hand)
function scard.costfilter(c)
	return c:IsBasicPokemon() or c:IsEvolution()
end
function scard.thfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. When you use Pokémon Trader, do you shuffle a Pokémon card into your deck or do you discard one?
	A. You shuffle it back into your deck. (6-29-00 Q69 WotC Chat)

	Q. When you use Pokémon Trader, do you have to trade a basic for a basic, stage 1 for stage 1 etc. or can you trade
	any Pokémon for any stage?
	A. You can trade for any stage. (April 6, 2000 WotC Chat Q163)

	Q. You can't search for a Mysterious Fossil or Clefairy Doll with Pokémon Trader, right?
	A. And you are correct you can't use Trader to pull one of them, as they are trainers when they are not in play.
	(April 6, 2000 WotC Chat Q172)

	Q. I use Pokémon Trader to search for a Pokémon, but there are none left. Do I put the card in anyway? Do I just
	pretend that I didnt play the card (since its requirements can't be fulfilled) or do I discard Pokémon trader?
	Would the answer be the same if there were 0 cards in my deck left?
	A. The card says to 'trade', if you can't do that don't put the card from your hand into your deck. You could still
	play the Trainer BUT you would NOT be able to trade so you would NOT put a Pokémon from your hand into your deck.
	(Nov 16, 2000 WotC Chat, Q142 & Q143)
	https://compendium.pokegym.net/compendium.html#trainers

	Q. Is there a difference between "trading" your cards such as Energy Retrieval and "discarding" your cards such as an
	Item Finder? Say that I only have one Energy in my discard pile, and I use Energy Retrieval using Energy to trade, You
	only are able to retrieve the Energy in your discard pile, not the card you traded. Right? Cause it would make sense
	about "trading".
	A. Yes, that's right. (Mar 2, 2000 WotC Chat)
	https://compendium.pokegym.net/compendium-lvx.html#34
]]
