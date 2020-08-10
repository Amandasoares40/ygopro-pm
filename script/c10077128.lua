--Mars (Ultra Prism 128/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, discard hand
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,2,REASON_EFFECT)==0 then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(tp,1)
	Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
end
--[[
	Rulings
	Q. If I use Mars with only 1 card left in my deck, can I still discard a random card from my opponent's hand?
	A. Yes, as long as you can draw at least 1 card you get the other effect. Of course if you can't draw any cards, you
	can't play Mars. (Ultra Prism FAQ; Feb 1, 2018 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#565
]]
