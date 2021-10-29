--Professor Rowan (Diamond & Pearl 112/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToDeck,LOCATION_HAND,0,1,c),scard.op1)
end
scard.trainer_supporter=true
--to deck, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_NTODECK)
	local sg=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	if sg:GetCount()>0 then
		g:Sub(sg)
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,4,REASON_EFFECT)
end
--[[
	Rulings
	Q. If I only have two cards in my hand and play Professor Rowan then I keep the one remaining card in my hand, but do
	I shuffle my deck or not (since I put zero cards from my hand into it)?
	A. Shuffling is a must when playing Professor Rowan regardless of whether you put any cards back into your deck or
	not. (Apr 3, 2008 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#559
]]
