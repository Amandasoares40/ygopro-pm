--Mary (Neo Genesis 87/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--draw, to deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,2,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,2,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
end
--[[
	Rulings
	Q. If you play a Mary Trainer card but you cannot draw 2 cards from your deck, can you still play Mary and shuffle 2
	cards from your hand back into your deck?
	A. Yes. (Jul 18, 2002 WotC Chat, Q9)
	https://compendium.pokegym.net/compendium.html#trainers
]]
