--Professor Oak (Base Set 88/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard hand, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
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
		Q. If the only card I have in my hand is Professor Oak, can I use it to draw 7 more cards?
		A. Yes, you can discard a hand of zero cards. (Mar 2 WotC Chat)
		http://compendium.pokegym.net/compendium.html#trainers
]]
