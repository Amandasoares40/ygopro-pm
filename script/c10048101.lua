--Professor Juniper (Black & White 101/114)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard hand, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
scard.clone=true
--discard hand, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,7,REASON_EFFECT)
end
--[[
	Rulings
	* While there are no functional changes to these cards [Professor Juniper and Professor Sycamore], you may not include
	both of them in your deck. That is, you may have up to 4 copies of Professor Juniper or up to 4 copies of Professor
	Sycamore - but if you have any Professor Juniper cards in your deck, you may not put any Professor Sycamore cards in
	your deck, and vice versa. (Oct 1, 2013 TPCi Announcements; Nov 21, 2013 TPCi Rules Team)

	Q. Can I play Professor Juniper if it is the only card in my hand, and then draw 7 cards?
	A. Yes, you basically discard your remaining hand of zero cards, then you draw 7 cards from your deck.
	(Black & White FAQ; Apr 28, 2011 PUI Rules Team)

	Q. Can you use Professor Juniper or Professor Sycamore with no cards in your deck, just to discard your hand?
	A. No, you cannot. Discarding your hand is a cost not the effect, and you cannot play Trainer cards for no effect.
	(Apr 27, 2017 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#311

	Note: This card's effect is identical to that of "Professor Oak".
]]
