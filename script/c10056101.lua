--Ghetsis (Plasma Freeze 101/116)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--confirm hand, to deck, draw
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_supporter=true
--confirm hand, to deck, draw
function scard.tdfilter(c)
	return c:IsItem() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local sg=g:Filter(scard.tdfilter,nil)
		Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
	Duel.ShuffleDeck(1-tp)
	Duel.ShuffleHand(1-tp)
	local ct=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if ct==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
--[[
	Rulings
	Q. What happens if you play Ghetsis but your opponent does not have any Item cards in their hand?
	A. Your opponent shuffles their deck (even though they did not put any cards into it) and you do not get to draw any
	additional cards. (Jun 20, 2013 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#296
]]
