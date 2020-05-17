--Island Hermit (Dragon Frontiers 76/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--turn prize, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--turn prize, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetPrize(tp):IsExists(Card.IsFacedown,1,nil) or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TURNPRIZEUP)
	--local g=Duel.SelectMatchingCard(tp,aux.PrizeFilter(Card.IsFacedown),tp,LOCATION_PRIZE,0,1,2,nil)
	local g=Duel.SelectMatchingPrizeCard(tp,Card.IsFacedown,tp,1,2,nil)
	if g:GetCount()>0 then
		Duel.TurnPrize(g,POS_FACEUP)
	end
	Duel.Draw(tp,2,REASON_EFFECT)
end
--[[
	Rulings
		Q. Island Hermit states "Choose up to 2" can I choose not to reveal any of my Prize cards?
		A. No. If you have any face-down Prize cards, you must put at least one of them face-up. But if all of your Prize
		cards are face-up, you can still play this Trainer card and draw 2 cards.
		(EX:Dragon Frontiers FAQ; Oct 26, 2006 PUI Rules Team)
		http://compendium.pokegym.net/compendium-ex.html#trainers
]]
