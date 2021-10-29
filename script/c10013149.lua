--Professor Oak's Research (Expedition 149/165)
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
	Duel.Draw(tp,5,REASON_EFFECT)
end
--[[
	Rulings
	Q. If the other player has a Slowking out and I play a Prof. Oak Research, do I have to shuffle my hand into the deck
	before the coin flip?
	A. No, it is not a cost of playing the card, it is an effect. (Apr 17, 2003 WotC Chat, Q1261)
	https://compendium.pokegym.net/compendium.html#trainers
]]
