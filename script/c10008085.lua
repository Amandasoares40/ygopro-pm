--Energy Charge (Neo Genesis 85/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to deck
function scard.tdfilter(c)
	return c:IsEnergy() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,LOCATION_DPILE,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	end
end
--[[
	Rulings
		Due to the fact that this card's name at the time of Power Charge's original Expedition Base Set release, and its
		effect slightly differed from Power Charge, it was ruled that "Energy Charge" and "Power Charge" were not the same
		card in the English-language printings.
		https://bulbapedia.bulbagarden.net/wiki/Energy_Charge_(Neo_Genesis_85)#Release_information
]]
