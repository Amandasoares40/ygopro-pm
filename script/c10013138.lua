--Copycat (Expedition 138/165)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
--[[
	Rulings
	Q. Can I use the Supporter "Copycat" when my opponent has no cards in his or her hand?
	A. Yes, you can. Shuffle your hand into your deck, but don't draw any cards.
	(GS:Heart Gold/Soul Silver FAQ; Feb 11, 2010 PUI Rules Team)

	Q. Can I play the Supporter "Copycat" when it's the only card in my hand?
	A. Yes, you can. Shuffle your deck, then draw cards equal to the number of cards in your opponent's hand.
	(GS:Heart Gold/Soul Silver FAQ; Feb 11, 2010 PUI Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#639
]]
