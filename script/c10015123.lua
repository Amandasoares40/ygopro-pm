--Desert Shaman (Skyridge 123/144)
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
	Duel.DrawUpTo(tp,4,REASON_EFFECT)
	Duel.DrawUpTo(1-tp,4,REASON_EFFECT)
end
--[[
	Rulings
	Q. Desert Shaman says, "Shuffle your hand into your deck and draw up to 4 cards; your opponent does the same".
	Does this mean that if you choose to only draw one card, your opponent only gets to draw one card? Or can they draw up
	to four if they want to?
	A. Each player can draw up to 4 cards. What you choose does not limit your opponent. (May 15, 2003 WotC Chat, Q1571)
	https://compendium.pokegym.net/compendium.html#trainers
]]
