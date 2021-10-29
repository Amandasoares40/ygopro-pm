--Team Galactic's Mars (Secret Wonders 126/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, to deck
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKBOTTOM,REASON_EFFECT)
end
--[[
	Rulings
	Q. Can Team Galactic's Mars be played when your deck consists of zero cards?
	A. No, you must be able to draw at least one card from your deck in order to play this card.
	(Mar 27, 2008 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#228
]]
