--Professor Elm (Neo Genesis 96/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
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
	Duel.Draw(tp,7,REASON_EFFECT)
	--cannot play trainer
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(DESC_PLAYER_CANNOT_PLAY_TRAINER)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,0)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--cannot play trainer
function scard.val1(e,re,tp)
	return re:IsActiveType(TYPE_TRAINER)
end
--[[
	Rulings
	* Professor Elm: You can choose to use this card on yourself or on your teammate during your turn. Either way, the
	person who is actually playing the card (takes it from his or her hand and discards it) cannot play any more Trainer
	cards that turn (this is a cost). (WotC Pokemon Multiplayer Rules v1.3, Jul 12, 2002)

	Q. Does Prof-Elming with 0 cards in your hand allow you to shuffle before drawing 7 cards?
	A. Yes. [ED.NOTE: In fact, it *REQUIRES* it to be shuffled before drawing 7 cards, even with a hand of zero].
	(Nov 14, 2002 WotC Chat, Q31)
	https://compendium.pokegym.net/compendium.html#trainers
]]
