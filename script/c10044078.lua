--Judge (Unleashed 78/95)
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
	Duel.Draw(tp,4,REASON_EFFECT)
	Duel.Draw(1-tp,4,REASON_EFFECT)
end
--[[
	Rulings
		Q. What happens if a player has no hand when "Judge" is played?
		A. The player shuffles his or her deck and draws 4 cards (or as many cards as possible if the deck contains less
		than 4 cards). (HS:Unleashed FAQ; May 13, 2010 PUI Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#156
	Note: This card's effect is almost identical to that of "Desert Shaman".
]]
