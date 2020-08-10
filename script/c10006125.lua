--Sabrina's Gaze (Gym Heroes 125/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_SABRINA)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
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
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	Duel.Draw(tp,ct1,REASON_EFFECT)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	Duel.Draw(1-tp,ct2,REASON_EFFECT)
end
--[[
	Rulings
	Q. Sabrina's Gaze says, "Each player shuffles his/her hand into his/her deck and draws a new hand of the same number
	of cards." So if someone has a zero-card hand, they still have to shuffle, right?
	A. That's right. Your hand can be 0. (Dec 7, 2000 WotC Chat, Q91)
	https://compendium.pokegym.net/compendium.html#trainers
]]
