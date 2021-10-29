--Imposter Oak's Revenge (Team Rocket 76/82)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,nil,aux.DiscardHandCost(1))
end
scard.trainer_item=true
--to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil)
		or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.Draw(1-tp,4,REASON_EFFECT)
end
--[[
	Rulings
	Q. If my opponent has no hand and I play Imposter Oak's Revenge, do they still shuffle their deck?
	A. Yes they would. (Nov 14, 2002 WotC Chat, Q16 & Q31)
	https://compendium.pokegym.net/compendium.html#trainers
]]
