--Team Galactic's Wager (Mysterious Treasures 115/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil)
		or Duel.IsPlayerCanDraw(tp,1) or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	local ct1=3
	local ct2=3
	if Duel.RockPaperScissors()==tp then ct1=6 else ct2=6 end
	Duel.DrawUpTo(tp,ct1,REASON_EFFECT)
	Duel.DrawUpTo(1-tp,ct2,REASON_EFFECT)
end
--[[
	Rulings
		Q. If I play Team Galactic's Wager can I choose to draw zero cards, or must each player draw at least one card
		since it says "UP TO 3" for losing or "UP TO 6" for winning?
		A. Each player must draw at least one card if they are able to. (Feb 21, 2008 PUI Rules Team)

		Q. Can I play Team Galactic's Wager if I or my opponent have no hand after playing the card... or no deck?
		A. Yes, both players do as much as they can of the required actions. A player with no hand will shuffle then draw
		and a player with no deck will shuffle in and draw. (Sep 18, 2007 PUI Rules Team)

		Q. If no one has any cards left in their deck, and no cards in their hand except for a single Team Galactic's
		Wager, can I play Team Galactic's Wager or not?
		A. No. At least one player must be able to draw a card. (Feb 21, 2008 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#193
]]
