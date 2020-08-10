--Volkner's Philosophy (Rising Rivals 98/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.cost1)
end
scard.trainer_supporter=true
--draw
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return ct<=6 end
	if ct>0 and Duel.SelectYesNo(tp,YESNOMSG_DISCARDHAND) then
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=6-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. Do you *have* to discard a card in order to use Volkner's Philosophy?
	A. No, the discard portion of Volkner's Philosophy is optional. (May 21, 2009 PUI Rules Team)

	Q. Can I play Volkner's Philosophy if I already have more than 6 cards in my hand? Or what if I don't have any cards
	in my deck?
	A. You have to be able to draw at least one card from your deck, regardless of whether you discard a card first or
	not. If you cannot draw any cards, due to having too many in your hand or zero in your deck, you cannot play this
	card. (May 21, 2009 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#399
]]
