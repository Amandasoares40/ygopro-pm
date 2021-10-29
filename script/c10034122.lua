--Professor Oak's Visit (Secret Wonders 122/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, to deck
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,3,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKBOTTOM,REASON_EFFECT)
end
--[[
	Rulings
	Q. If I have no cards left in my deck, can I use Prof. Oak's Visit to put one card from my hand back into my deck pile
	so I don't run out of cards the next turn?
	A. No, since you are unable to draw any cards you cannot play Professor Oak's Visit. (Feb 7, 2008 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#201
]]
