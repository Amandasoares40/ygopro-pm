--Lost Blender (Lost Thunder 181/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to lost, draw
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToLost,LOCATION_HAND,0,2,c),scard.op1)
end
scard.trainer_item=true
--to lost, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOLZONE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToLost,tp,LOCATION_HAND,0,2,2,nil)
	if g:GetCount()==2 and Duel.SendtoLost(g,REASON_EFFECT)==2 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--[[
	Rulings
		Q. Can I play Lost Blender if I only have one card in my hand to put into the Lost Zone?
		A. No, you cannot play Lost Blender unless you put 2 cards from your hand in the Lost Zone.
		(Jan 3, 2019 TPCi Rules Team)

		Q. Can I play Lost Blender if there are no cards left in my deck to draw from?
		A. Yes, you can. Putting cards into the Lost Zone is the main effect, so you can use this even if you have no
		cards in your deck. However, you cannot play it unless you can put 2 cards from your hand in the Lost Zone.
		(Jan 3, 2019 TPCi Rules Team; Mar 21, 2019 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#634
]]
